//
//  MainTabBarController.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import Combine
import ComposableArchitecture

final class MainTabBarController: UITabBarController {
    private var cancellable = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        setUpTabBarController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: - Set Up

private extension MainTabBarController {
    func setUp() {
        App.shared.$mainMenuToggle
            .dropFirst()
            .sink { [weak self] _ in
                self?.presentMenuView()
            }
            .store(in: &cancellable)

//        App.shared.$goReportScreen
//            .dropFirst()
//            .sink { [weak self] _ in
//               // self?.selectedIndex = 1
//            }
//            .store(in: &cancellable)

    }
    
    func setUpTabBarController() {
        func createNavigationController(rootViewController: UIViewController) -> UINavigationController {
            let nc = UINavigationController(rootViewController: rootViewController)
            nc.isNavigationBarHidden = true
            nc.delegate = self
            
            return nc
        }
        
        selectedIndex = 0
        delegate = self
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .darkGray
        
        let nc1 = createNavigationController(rootViewController: UIHostingController(rootView: HomeUI()))
        let nc2 = createNavigationController(rootViewController: UIHostingController(rootView: CalendarUI()))
        
        nc1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        nc2.tabBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar"), tag: 1)
        
        setViewControllers([nc1, nc2], animated: false)
        
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        setScrollToTopOnCurrentTab(currentTabBarVC: tabBarController, currentVC: viewController)
        return true
    }
    
    func setScrollToTopOnCurrentTab(currentTabBarVC: UITabBarController, currentVC: UIViewController) {
        let currentTabBarController = currentTabBarVC.selectedViewController
        if currentVC == currentTabBarController {
            let currentIndex = currentTabBarVC.selectedIndex
            switch currentIndex {
            // 홈
            case 0:
                NotificationCenter.default.post(name: .HomeScrollTop, object: nil)
            // 캘린더
            case 1:
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .CalendarScrollTop, object: nil)
                }
            default: break
            }
        }
    }
}

extension MainTabBarController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard operation == .push
        else { return nil }
        
        toVC.hidesBottomBarWhenPushed = true
        
        return nil
    }
}

// MARK: - Present

private extension MainTabBarController {
//    func presentQR() {
//        let vc = QRSignInViewController()
//        present(vc, animated: true)
//    }
    
    private func presentMenuView() {
      //  let nc = UINavigationController(rootViewController: MainMenuViewController())
        let nc = UINavigationController(rootViewController: UIHostingController(rootView: HomeUI()))
        nc.isNavigationBarHidden = true
        nc.delegate = self
        nc.transitioningDelegate = self
        nc.hidesBottomBarWhenPushed = true
        nc.modalPresentationStyle = .overFullScreen
        present(nc, animated: true)
    }
}


// MARK: - Transition For Menu

extension MainTabBarController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuTransitionAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuTransitionAnimator()
    }
}


class MenuTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        let isPresenting = toViewController.presentingViewController == fromViewController
        
        if isPresenting {
            // Presented
            containerView.addSubview(toViewController.view)
            toViewController.view.frame.origin.x = containerView.frame.width
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toViewController.view.frame.origin.x = 0
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            // Dismissed
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromViewController.view.frame.origin.x = containerView.frame.width
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

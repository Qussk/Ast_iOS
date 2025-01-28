//
//  AppDelegate.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import CoreData
import Combine
import ComposableArchitecture
  
@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
    var cancellable = Set<AnyCancellable>()
    
    func saveContext() {
        CoreDataStack.shared.saveContext()
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = .black
        
        resetRootViewController(rootVc: UIHostingController(rootView: SplashUI()))

        return true
    }

}

extension AppDelegate {
    func resetRootViewController(rootVc: UIViewController? = MainTabBarController()) {
        self.window?.rootViewController = rootVc
        self.window?.makeKeyAndVisible()
    }
}

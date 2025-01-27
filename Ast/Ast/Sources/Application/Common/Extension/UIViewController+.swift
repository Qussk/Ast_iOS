//
//  UIViewController+.swift
//  Ast
//
//  Created by 변윤나 on 1/27/25.
//

import UIKit
import SnapKit

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        DispatchQueue.main.async { [weak self] in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = .clear
            label.textColor = .white
            label.textAlignment = .center
            label.font = .h8
            label.numberOfLines = 3
            label.text = message
            
            let toastView = UIView()
            toastView.translatesAutoresizingMaskIntoConstraints = false
            toastView.clipsToBounds = true
            toastView.alpha = 1
            toastView.backgroundColor = UIColor.b2.withAlphaComponent(0.8)
            toastView.layer.cornerRadius = 25
            
            toastView.addSubview(label)
            self?.view.addSubview(toastView)
            
            label.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(15)
                make.top.bottom.equalToSuperview().inset(15)
            }
            
            let height = self?.view.frame.size.height ?? 0
            
            toastView.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(20)
                make.trailing.equalToSuperview().inset(20)
                make.bottom.equalTo(-height/8)
                make.centerX.equalToSuperview()
            }
            
            self?.view.bringSubviewToFront(toastView)

            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut) {
                toastView.alpha = 0
            } completion: { _ in
                toastView.removeFromSuperview()
            }
        }
    }
}

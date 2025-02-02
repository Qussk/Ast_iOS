//
//  ScreanThemeManager.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import SwiftUI


class ScreanThemeManager {
    static let shared = ScreanThemeManager()
    
    //////다크모드인지 여부 확인
    var isDarkMode: Bool {
        return UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }
    
    var toDarkMode: String {
        return UserDefaults.isDark ? "Dark" : "Light"
    }
    
    func toggleTheme(toggle: Bool) {
        if toggle {
            // 라이트모드로 변경
            switchToLightMode()
        } else {
            // 다크모드로 변경
            switchToDarkMode()
        }
    }
    
    private func switchToLightMode() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = .light
        }
    }
    
    private func switchToDarkMode() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = .dark
        }
    }
}

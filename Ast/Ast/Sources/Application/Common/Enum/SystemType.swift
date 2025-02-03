//
//  SystemType.swift
//  Ast
//
//  Created by 변윤나 on 1/23/25.
//

import Foundation
import SwiftUI

struct SystemSetting {
    //전체메뉴
    enum MenuType: String, CaseIterable {
        case alarm = "알림설정"
        case themeColor = "테마변경"
        case darkMode = "Light/Dark Mode" //"화면모드"
        case terms = "이용약관"
        case review = "앱리뷰쓰기"
        
        var imageName: String {
            switch self {
            case .alarm:
                return "alarm"
            case .themeColor:
                return "themeColor"
            case .darkMode:
                return "darkMode"
            case .terms:
                return "terms"
            case .review:
                return "review"
            }
        }
    }
}

enum SystemColorType {
}

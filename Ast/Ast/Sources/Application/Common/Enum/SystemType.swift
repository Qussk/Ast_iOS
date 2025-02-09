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
        case theme = "테마변경"
        case darkMode = "Light/Dark Mode" //"화면모드"
        case terms = "이용약관"
        case review = "앱리뷰쓰기"
        
        var imageName: String {
            switch self {
            case .alarm:
                return "alarm"
            case .theme:
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
    

    enum ColorType: Int, CaseIterable {
        case none = 0
        case theme_c2
        case theme_c3
        case theme_c4
        case theme_c5
        case theme_c6
        case theme_c7
                
        var colors: Color {
            switch self {
            case .none:
                return Color.orange
            case .theme_c2:
                return .c2
            case .theme_c3:
                return .c3
            case .theme_c4:
                return .c4
            case .theme_c5:
                return .c5
            case .theme_c6:
                return .c6
            case .theme_c7:
                return .c7
            }
        }
        
        var hexCodes: String {
            switch self {
            case .none:
                return "#F19A37"
            case .theme_c2:
                return "#827E93"
            case .theme_c3:
                return "#D0C7BE"
            case .theme_c4:
                return "#DC6C56"
            case .theme_c5:
                return "#E0C255"
            case .theme_c6:
                return "#2C3D50"
            case .theme_c7:
                return "#682566"
            }
        }
    }
}


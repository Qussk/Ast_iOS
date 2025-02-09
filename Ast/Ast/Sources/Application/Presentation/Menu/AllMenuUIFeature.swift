//
//  AllMenuUIFeature.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import SwiftUI
import ComposableArchitecture



@Reducer
struct AllMenuUIFeature {
    struct State: Equatable {
        var path = StackState<Path.State>()
        var astroNm: String = "aries"
        var progress: CGFloat = 0.25
        var impartText = ImpartStringData.impartText.shuffled()
        var amount: Int = 1
        var rank: Int = 4

        //theme
        var isTheme:Bool = false
        var selectColor: SystemSetting.ColorType = .none
        @BindingState var hexText: String = ""
        var isValid:Bool = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case viewAppeared
        case path(StackAction<Path.State, Path.Action>)
        case selectedMenu(SystemSetting.MenuType)
        case selectColor(SystemSetting.ColorType)
        case onChangeTextField(text: String)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .viewAppeared:
                let myColor = UserDefaults.myColor
                if let matchingColor = colorType(from: myColor) {
                    state.selectColor = matchingColor
                }
                else {
                    state.hexText = myColor
                    state.isValid = true
                }
                return .none
            case .selectedMenu(let option):
                switch option {
                case .theme:
                    state.isTheme.toggle()
                default: break
                }
                return .none
            case .selectColor(let color):
                state.selectColor = color
                UserDefaults.myColor = color.colors.toHex()
                return .none
            case .onChangeTextField(let text):
                state.hexText = text
                state.isValid = isValid(hex: text) ? true : false
                if state.isValid {
                    UserDefaults.myColor = text
                }
                return .none
            case let .path(action):
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
    
    struct Path: Reducer {
        enum State: Equatable {
            case alarm(AlarmSettingUIFeature.State = .init())
        }
        
        enum Action: Equatable {
            case alarm(AlarmSettingUIFeature.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: /State.alarm, action: /Action.alarm) {
                AlarmSettingUIFeature()
            }
        }
    }
}

extension AllMenuUIFeature {
    private func isValid(hex: String) -> Bool {
        /// 정규 표현식 패턴: #RRGGBB
        let hexPattern = "^#[A-Fa-f0-9]{6}$"
        let hexTest = NSPredicate(format: "SELF MATCHES %@", hexPattern)
        return hexTest.evaluate(with: hex)
    }
    
    private func colorType(from hexCode: String) -> SystemSetting.ColorType? {
        return SystemSetting.ColorType.allCases.first(where: { $0.hexCodes == hexCode })
    }


}

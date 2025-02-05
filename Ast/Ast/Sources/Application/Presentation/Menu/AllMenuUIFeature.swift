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
    }
    
    enum Action: Equatable {
        case viewAppeared
        case path(StackAction<Path.State, Path.Action>)
        case selectedMenu(SystemSetting.MenuType)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case .selectedMenu(let option):
//                print(option)
                switch option {
                case .alarm: break
                case .themeColor: break
                case .darkMode: break
                default:
                    break
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

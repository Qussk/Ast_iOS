//
//  ProfileUIFeature.swift
//  Ast
//
//  Created by 변윤나 on 2/14/25.
//

import SwiftUI
import ComposableArchitecture


@Reducer
struct ProfileUIFeature {
    enum ProfileType {
        case name
        case gender
        case birth
        case time
        case region
    }
    
    struct State: Equatable {
        var myColor:Color = .orange
        var title:String = ""
        var isColsed:Bool = false
        @BindingState var nameText:String = UserDefaults.userName
        var gender: Int = UserDefaults.userGender
        var birth: String = UserDefaults.userBirth
        var time: String = UserDefaults.userTime
        var region: String = UserDefaults.userRegion

    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case viewAppeared(ProfileUIFeature.ProfileType)
        case setProfileTitle(ProfileUIFeature.ProfileType)
        case setName(String)
        case setGender(Int)
        case setBirth(String)
        case setTime(String)
        case setRegion(String)
        case confirm(ProfileUIFeature.ProfileType)
    }
    
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .viewAppeared(let type):
                state.isColsed = true
                state.myColor = Color.fromHex(hex: UserDefaults.myColor)
                return .run { send in
                    await send(.setProfileTitle(type))
                }
            case .setProfileTitle(let type):
                switch type {
                case .name:
                    state.title = "닉네임을 입력해 주세요."
                case .gender:
                    state.title = "성별을 선택해 주세요."
                case .birth:
                    state.title = "생년월일을 선택해 주세요."
                case .time:
                    state.title = "태어난 시간을 선택해 주세요."
                case .region:
                    state.title = "태어난 장소를 선택해 주세요."
                }
                return .none
            case .setName(let text) :
                state.nameText = text
                return .none
            case .setGender(let id) :
                state.gender = id
                return .none
            case .setBirth(let date) :
                state.birth = date
                return .none
            case .setRegion(let region) :
                state.region = region
                return .none
            case .setTime(let time) :
                state.time = time
                return .none
            case .confirm(let type) :
                switch type {
                case .name:
                    if state.nameText.count > 8 {
                        state.nameText = String(state.nameText.prefix(8))
                    }
                    UserDefaults.userName = state.nameText
                case .gender:
                    UserDefaults.userGender = state.gender
                case .birth:
                    UserDefaults.userBirth = state.birth
                case .time:
                    UserDefaults.userTime = state.time
                case .region:
                    UserDefaults.userRegion = state.region
                }
                state.isColsed = true
                return .none
            default :
                return .none
            }
        }
    }
}

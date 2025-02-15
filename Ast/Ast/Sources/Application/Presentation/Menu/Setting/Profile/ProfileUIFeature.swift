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
        let profileType: ProfileUIFeature.ProfileType = .name
        let title:String = "닉네임을 입력해 주세요."
        @BindingState var nameText:String = ""
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case viewAppeared
        case setEditType(ProfileUIFeature.ProfileType)
    }
    
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                state.myColor = Color.fromHex(hex: UserDefaults.myColor)
                return .none
            default :
                return .none
            }
        }
    }
}

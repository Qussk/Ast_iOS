//
//  SignUpFeature.swift
//  Ast
//
//  Created by 변윤나 on 2/13/25.
//
import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct SignUpFeature {
    enum filedType {
        case birth
        case time
        case region
    }
    
    struct State: Equatable {
        @BindingState var birth: String = ""
        var gender: UserType.Gender = .female
        @BindingState var time: String = ""
        @BindingState var region: String = ""
        var personal: Bool = false
        var marketing: Bool = false
    }
    
    enum Action:BindableAction, Equatable {
        case binding(BindingAction<State>)
        case viewAppeared
        case confirm
    }
        
    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .viewAppeared:
                return .none
            case .confirm:
                return .run { _ in
                    await self.dismiss()
                }
                return .none
            default :
                return .none
            }
        }
    }
}


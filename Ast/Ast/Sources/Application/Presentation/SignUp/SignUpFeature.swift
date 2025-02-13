//
//  SignUpFeature.swift
//  Ast
//
//  Created by 변윤나 on 2/13/25.
//
import Foundation
import ComposableArchitecture

@Reducer
struct SignUpFeature {
    struct State: Equatable {
    }
    
    enum Action: Equatable {
        case binding(BindingAction<State>)
        case viewAppeared
    }
        
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            default :
                return .none
            }
        }
    }
}


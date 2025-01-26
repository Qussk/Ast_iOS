//
//  HomeFeature.swift
//  Ast
//
//  Created by 변윤나 on 1/25/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
    enum LeadType: String, CaseIterable {
        case daily = "일일"
        case monthly = "월간"
        case yearly = "년간"
    }

    struct State: Equatable {
        @PresentationState var isSelection: HomeFeature.State?
        var selectedTab: LeadType = .daily
    }
    
    enum Action: Equatable {
        case viewAppeared
        case selectTab(LeadType)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case .selectTab(let tab):
                state.selectedTab = tab
                return .none
            }
        }
    }
}

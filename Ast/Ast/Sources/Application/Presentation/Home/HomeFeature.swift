//
//  HomeFeature.swift
//  Ast
//
//  Created by 변윤나 on 1/25/25.
//

import Foundation
import ComposableArchitecture
import UIKit

@Reducer
struct HomeFeature {
    enum LeadType: String, CaseIterable {
        case daily = "일일"
        case monthly = "월간"
        case yearly = "년간"
    }
    
    struct State: Equatable {
        @PresentationState var isSelection: HomeFeature.State?
        var isLandscape = UIDevice.current.orientation.isLandscape //가로 : true, 세로 : false
        var selectedTab: LeadType = .daily
        let currentMonthlydate = Date()
    }
    
    enum Action: Equatable {
        case viewAppeared
        case selectTab(LeadType)
        case toAllMenuTapped
        case orientationChanged(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case .selectTab(let tab):
                state.selectedTab = tab
                return .none
            case .toAllMenuTapped:
                print("전체메뉴")
                return .none
            case .orientationChanged(let isLandscape):
                state.isLandscape = isLandscape
                return .none
            }
        }
    }
   
}

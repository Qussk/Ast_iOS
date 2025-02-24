//
//  CalendarFeature.swift
//  Ast
//
//  Created by 변윤나 on 2/23/25.
//

import Foundation
import ComposableArchitecture



@Reducer
struct CalendarFeature {
    struct State: Equatable {
        var isNeedToUpdate: Bool = false
        var currentDate = Date()

    }
    
    enum Action: Equatable {
        case viewAppeared
        case cancelButtonTapped
        case calendarDidSelected(isSelectedByUser: Bool = true, toDate: Date)
        case settingUpdateFlag
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

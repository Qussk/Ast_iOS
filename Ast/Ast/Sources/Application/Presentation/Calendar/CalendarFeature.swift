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
        var currentMonth: String = Date().toFormateString(dateFormat: .ko_yyyy_MM)
        var isPreviousMonthButtonEnabled: Bool {
            guard let targetDate = currentDate.addMonths(0),
                  let currentMonthStart = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date())) else { return false }
            if targetDate >= currentMonthStart {
                return true
            } else {
                return false
            }
        }
    }
    
    enum Action: Equatable {
        case viewAppeared
        case cancelButtonTapped
        case calendarDidSelected(isSelectedByUser: Bool = true, toDate: Date)
        case settingUpdateFlag
        case previousMonthNavigationButtonTapped
        case nextMonthNavigationButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case .previousMonthNavigationButtonTapped:
                guard let targetDate = state.currentDate.addMonths(-1) else { return .none }
                if state.isPreviousMonthButtonEnabled {
                    state.currentDate = targetDate
                    state.currentMonth = targetDate.toFormateString(dateFormat: .ko_yyyy_MM)
                }
                return .none
            case .nextMonthNavigationButtonTapped:
                guard let targetDate = state.currentDate.addMonths(1) else { return .none }
                state.currentDate = targetDate
                state.currentMonth = targetDate.toFormateString(dateFormat: .ko_yyyy_MM)
//                return .run { await $0(.requestHoliydays(date: targetDate.toFormateString(dateFormat: .yyyy_MM))) }
                return .none
            default :
                return .none
            }
        }
    }
}

//
//  CalendarUI.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import FSCalendar
import ComposableArchitecture

struct CalendarUI: View {
    let reportScreenScrollTop = NotificationCenter.default.publisher(for: .CalendarScrollTop)
    let season = CalendarType.Season.currentSeason()
    let store: StoreOf<CalendarFeature> = Store(initialState: CalendarFeature.State()) { CalendarFeature() }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(season.rawValue) 이달의 Best  🤸🏼")
                        .fontColor(.s1, color: .b1)
                        .padding(.leading, 18)
                        .padding(.vertical, 20)
                    
                    calendarNavigationView(with: viewStore)
                    
                    CalendarRepresentable(viewStore: viewStore)
                        .frame(height: 400)
                        .padding(.top, 24)
                        .padding(.horizontal, 24)
                    
                    //            Spacer()
                }
            }
        }
    }
    
    private func calendarNavigationView(with viewStore: ViewStore<CalendarFeature.State,
                                        CalendarFeature.Action>) -> some View {
        HStack(spacing: 14) {
            Spacer()
            navigationButton(with: viewStore, imageName: "ico_t_16x16_solid_arrow_left", buttonType: .left) {
                viewStore.send(.previousMonthNavigationButtonTapped)
            }
            
            Text(viewStore.currentMonth)
                .fontColor(.h4, color: .b1)
            
            navigationButton(with: viewStore, imageName: "ico_t_16x16_solid_arrow_right", buttonType: .right) {
                viewStore.send(.nextMonthNavigationButtonTapped)
            }
            Spacer()
        }
        .frame(height: 24)
        .padding(.top, 30)
    }
    
    enum TicketCalendarNavigationButtonType {
        case left
        case right
    }
    
    private func navigationButton(with viewStore: ViewStore<CalendarFeature.State,
                                  CalendarFeature.Action>, imageName: String, buttonType: TicketCalendarNavigationButtonType, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(buttonType == .right ? .b2 : viewStore.isPreviousMonthButtonEnabled ? .b2 : .b4)
        }
        .padding(.horizontal, 4)
        .disabled(buttonType == .left ? !viewStore.isPreviousMonthButtonEnabled : false)
    }

}


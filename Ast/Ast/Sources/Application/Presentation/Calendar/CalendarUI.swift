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
    let store: StoreOf<CalendarFeature> = Store(initialState: CalendarFeature.State()) { CalendarFeature() }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            Text("Hello, CalendarUI!")
            
            CalendarRepresentable(viewStore: viewStore)
                .padding(.top, 24)
        }
    }
}


//
//  CalendarUI.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import ComposableArchitecture

struct CalendarUI: View {
    let reportScreenScrollTop = NotificationCenter.default.publisher(for: .CalendarScrollTop)

    var body: some View {
        Text("Hello, CalendarUI!")
    }
}

#Preview {
    CalendarUI()
}

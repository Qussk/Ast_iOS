//
//  MonthlyUI.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture

//MARK: 컨텐츠 - 월간
struct MonthlyUI: View {
    let store: StoreOf<HomeFeature> = Store(initialState: HomeFeature.State()) { HomeFeature() }
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    Text(viewStore.currentMonthlydate.isCurrentDate())
                        .font(.largeTitle).bold()
                        .padding(.horizontal, 18)
                }
                .padding(.vertical, 10)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

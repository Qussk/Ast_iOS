//
//  YearlyUI.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture

//MARK: 컨텐츠 - 년간
struct YearlyUI: View {
    let store: StoreOf<HomeFeature> = Store(initialState: HomeFeature.State()) { HomeFeature() }
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    Text("YearlyUI")
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

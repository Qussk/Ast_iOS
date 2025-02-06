//
//  ThemeSettingUI.swift
//  Ast
//
//  Created by 변윤나 on 2/6/25.
//

import SwiftUI
import ComposableArchitecture

struct ThemeSettingUI: View {
    let store: StoreOf<ThemeSettingUIFeature> = Store(initialState: ThemeSettingUIFeature.State(), reducer: { ThemeSettingUIFeature() })

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ThemeSettingUI()
}

@Reducer
struct ThemeSettingUIFeature {
    struct State: Equatable {
        
    }
    enum Action: Equatable {
        case viewAppeared
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
                
            }
        }
    }
}

//
//  AlarmSettingUI.swift
//  Ast
//
//  Created by 변윤나 on 2/3/25.
//

import SwiftUI
import ComposableArchitecture

struct AlarmSettingUI: View {
    let store: StoreOf<AlarmSettingUIFeature> = Store(initialState: AlarmSettingUIFeature.State(), reducer: { AlarmSettingUIFeature() })
//    let store: StoreOf<AllMenuUIFeature>

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                NavigationBarView(title: "알림설정") {
                    dismiss()
                }
                Spacer()
                
            }
            .navigationBarBackButtonHidden()

        }
    }
}

#Preview {
    AlarmSettingUI()
}

@Reducer
struct AlarmSettingUIFeature {
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

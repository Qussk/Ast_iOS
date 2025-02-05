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
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBarView(title: "알림설정") {
                    dismiss()
                }
                SettingListItem(
                    type: .alarm(.today),
                    image: "",
                    title: "매일 알림",
                    subTitle: "매일 정해진 시간에 운세 업데이트 알림을 받아요.",
                    value: "",
                    toggle: true
                )
                
                SettingListItem(
                    type: .alarm(.rank),
                    image: "",
                    title: "1위때만 알림",
                    subTitle: "1위였을때만 알림을 받아요.",
                    value: "",
                    toggle: true
                )
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
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

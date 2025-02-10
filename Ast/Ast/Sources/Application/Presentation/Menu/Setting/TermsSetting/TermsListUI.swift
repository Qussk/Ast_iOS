//
//  TermsListUI.swift
//  Ast
//
//  Created by 변윤나 on 2/9/25.
//

import SwiftUI
import ComposableArchitecture

struct TermsListUI: View {
    let store: StoreOf<TermsListUIFeature> = Store(initialState: TermsListUIFeature.State(), reducer: { TermsListUIFeature() })
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                NavigationBarView(title: "이용약관") {
                    dismiss()
                }
                SettingListItem(
                    type: .terms(.personal),
                    image: "",
                    title: "개인정보처리방침",
                    subTitle: "",
                    value: "",
                    toggle: false
                )
                .onTapGesture {
                    
                }
                
                SettingListItem(
                    type: .terms(.marketing),
                    image: "",
                    title: "마케팅 광고 활용 동의",
                    subTitle: "",
                    value: "",
                    toggle: false
                )
                .onTapGesture {
                    
                }
                //WebUI
            }
            .onAppear {
                viewStore.send(.viewAppeared)
            }

            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TermsListUI()
}

@Reducer
struct TermsListUIFeature {
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

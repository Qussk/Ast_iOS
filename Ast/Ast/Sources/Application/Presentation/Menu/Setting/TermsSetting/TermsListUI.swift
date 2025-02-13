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
                    title: WebUIType.personal.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: false
                )
                .onTapGesture {
                    viewStore.send(.goTo(.personal))
                }
                
                SettingListItem(
                    type: .terms(.marketing),
                    image: "",
                    title: WebUIType.marketing.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: false
                )
                .onTapGesture {
                    viewStore.send(.goTo(.marketing))
                }

            }
            Spacer()

            .onAppear {
                viewStore.send(.viewAppeared)
            }
            .fullScreenCover(store: store.scope(state: \.$toPersonal, action: { .toPersonal($0) }), content: {
                store in
                WebUI(store: store)
                    .navigationBarBackButtonHidden()
            })
            .fullScreenCover(store: store.scope(state: \.$toMarketing, action: { .toMarketing($0) }), content: {
                store in
                WebUI(store: store)
                    .navigationBarBackButtonHidden()
            })
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TermsListUI()
}

@Reducer
struct TermsListUIFeature {
    enum Item: Int  {
        case personal = 0
        case marketing
    }
    
    struct State: Equatable {
        @PresentationState var toPersonal: WebUIFeature.State?
        @PresentationState var toMarketing: WebUIFeature.State?
    }
    
    enum Action: Equatable {
        case viewAppeared
        case toPersonal(PresentationAction<WebUIFeature.Action>)
        case toMarketing(PresentationAction<WebUIFeature.Action>)
        case goTo(Item)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case .goTo(let item):
                switch item {
                case .personal:
                    var webUIFeature = WebUIFeature.State(title: WebUIType.personal.rawValue, url: WebURL.isPersonal)
                    webUIFeature.type = .personal
                    state.toPersonal = webUIFeature
                    return .none
                case .marketing:
                    var webUIFeature = WebUIFeature.State(title: WebUIType.marketing.rawValue, url: WebURL.isMarketing)
                    webUIFeature.type = .marketing
                    state.toMarketing = webUIFeature
                    return .none
                }
            default:
                return .none
            }
        }
        .ifLet(\.$toPersonal, action: \.toPersonal) {
            WebUIFeature()
        }
        .ifLet(\.$toMarketing, action: \.toMarketing) {
            WebUIFeature()
        }

    }
}

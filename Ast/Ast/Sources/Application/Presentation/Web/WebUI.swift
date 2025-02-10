//
//  WebUI.swift
//  Ast
//
//  Created by 변윤나 on 2/9/25.
//

import SwiftUI
import ComposableArchitecture

struct WebUI: View {
    let store: StoreOf<WebUIFeature> = Store(initialState: WebUIFeature.State(), reducer: { WebUIFeature() })

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                WebViewNavigation(store: store)
                WebViewRepresentable(urlString: viewStore.url)
            }
            Spacer()
        }
    }
}

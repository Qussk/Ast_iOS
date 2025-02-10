//
//  WebViewNavigation.swift
//  Ast
//
//  Created by 변윤나 on 2/9/25.
//

import SwiftUI
import ComposableArchitecture

struct WebViewNavigation: View {
    let store: StoreOf<WebUIFeature>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    
                    // Back button
                    HStack {
                        Button(action: {
                            viewStore.send(.close)
                        }) {
                            Image(systemName: "chevron.backward")
                                .tint(Color(.black))
                                .frame(width: 24, height: 24)
                        }
                    }.frame(width: 24, height: 24)
                        .padding(.leading, 18)
                    
                    Spacer()
                    Text(viewStore.title)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .padding(.leading, -35)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: 55)
            .onChange(of: viewStore.isClose) { isClose in
                if isClose {
                    dismiss()
                }
            }
        }
    }
}

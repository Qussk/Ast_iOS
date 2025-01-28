//
//  SplashUI.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import ComposableArchitecture

struct SplashUI: View {
    let store: StoreOf<SplashFeature> = Store(initialState: SplashFeature.State()) { SplashFeature() }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 12) {
                    Text("👽")
                    Text("AST")
                        .fontColor(.h3 ,color: .white)
                }
                .padding(.top, 300)
                
                Spacer()
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .onAppear {
                viewStore.send(.viewAppeared)
            }
        }
    }
}

#Preview {
    SplashUI()
}

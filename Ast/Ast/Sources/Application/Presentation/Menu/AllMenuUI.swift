//
//  AllMenuUI.swift
//  Ast
//
//  Created by 변윤나 on 1/28/25.
//

import SwiftUI
import ComposableArchitecture

struct AllMenuUI: View {
    let store: StoreOf<AllMenuUIFeature> = Store(initialState: AllMenuUIFeature.State(), reducer: { AllMenuUIFeature() })
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 0) {
                        HStack(spacing: 10) {
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Image("close")
                                    .resizable()
                                    .tint(.b1)
                                    .frame(width: 28, height: 28)
                            }
                            .padding(.trailing, 18)
                            
                        }
                        
                        MenuTop(store: self.store)
                        MenuCreditUI(store: self.store)
                        PageTurnTextView(texts: viewStore.impartText, duration: 10)
                        MenuListUI(store: store)
                        Spacer()
                        
                        
                        Text("ver: \(App.appVersion)")
                            .fontColor(.l1, color: .b1)
                            .padding(.bottom, 30)
                    }
                    .onAppear {
                        viewStore.send(.viewAppeared)
                    }
                }
            }
        }
    }
}



#Preview {
    AllMenuUI()
}

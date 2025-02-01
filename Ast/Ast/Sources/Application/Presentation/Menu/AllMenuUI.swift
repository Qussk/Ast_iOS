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
                    Spacer()

                    
                    MenuTop(store: self.store)
                       
                    Spacer()
                    
                    
                }
                .onAppear {
                    viewStore.send(.viewAppeared)
                }
            }
        }
    }
}

#Preview {
    AllMenuUI()
}


@Reducer
struct AllMenuUIFeature {
    struct State: Equatable {
        var astroNm: String = "aries"
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

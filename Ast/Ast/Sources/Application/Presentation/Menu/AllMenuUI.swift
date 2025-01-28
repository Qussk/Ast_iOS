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
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .onAppear {
                viewStore.send(.viewAppeared)
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

//
//  DonationAlertUI.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture


struct DonationAlert: View {
    let store: StoreOf<DonationAlertFeature> = Store(initialState: DonationAlertFeature.State()) { DonationAlertFeature() }
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
        }
    }
}


@Reducer
struct DonationAlertFeature {
    struct State: Equatable, Hashable {}
    
    enum Action: Equatable {
        case confirm
        case close
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .confirm:
                return .none
            case .close:
                return .none
            }
        }
    }
}



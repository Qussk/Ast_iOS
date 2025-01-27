//
//  DonationAlertUI.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture


struct DonationPopupUI: View {
    let store: StoreOf<DonationPopupUIFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                
            }
        }
    }
}

@Reducer
struct DonationPopupUIFeature {
    struct State: Equatable {
        @PresentationState var dailyPopup: DonationPopupUIFeature.State?
    }
    
    enum Action: Equatable {
        case confirm
        case cancel
        case dailyPopup(PresentationAction<DonationPopupUIFeature.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .confirm:
                return .run { _ in
                    await self.dismiss()
                }
            case .cancel:
                return .run { _ in
                    await self.dismiss()
                }
            case .dailyPopup:
                return .none
            }
        }
    }
}



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
    @State private var isPressed = false

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack{
                Color.black.opacity(0.4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewStore.titleText)
                        .fontColor(.h2, color: .b1)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                    Text(viewStore.subText)
                        .fontColor(.h8, color: .b2)
                        .padding(.horizontal, 24)

                    Image(systemName: "pencil")
                    
                    Button {
                        viewStore.send(.confirm)
                    } label: {
                        HStack {
                            Spacer()
                            Text("광고보고 복채 내기(💰+2 획득)")
                                .fontColor(.h6, color: .white)
                            Spacer()
                        }
                        .frame(height: 50)
                    }
                    .background(.c1)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 20)

                    
                    Button {
                        viewStore.send(.cancel)
                    } label: {
                        HStack {
                            Spacer()
                            Text("괜찮아요")
                                .fontColor(.h6, color: .white)
                            Spacer()
                        }
                        .frame(height: 50)
                    }
                    .background(.b3)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)



                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal, 40)
                .fixedSize(horizontal: false, vertical: true)
            }
            .ignoresSafeArea()
            .onTapGesture {
                viewStore.send(.confirm)
            }
        }
    }
}

@Reducer
struct DonationPopupUIFeature {
    struct State: Equatable {
        var titleText:String = "운세가 너무 찰떡이에요!"
        var subText:String = "후덜덜..혹시 저 보고 계세요..?"
        var isOn: Bool = false
    }
    
    enum Action: Equatable {
        case confirm
        case cancel
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
            }
        }
    }
}



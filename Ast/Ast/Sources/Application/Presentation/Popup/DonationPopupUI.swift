//
//  DonationAlertUI.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture


struct CommonPopupUI: View {
    let store: StoreOf<CommonPopupUIFeature>
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

                    Image(viewStore.imageName)
                        .resizable()
                        .padding(.top, 10)
                        .frame(width: 160, height: 154)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(viewStore.bottomText)
                        .fontColor(.l1, color: .b1)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 10)
                    Button {
                        viewStore.send(.confirm)
                    } label: {
                        HStack {
                            Spacer()
                            Text(viewStore.confirmText)
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
                            Text(viewStore.cancelText)
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
            .onAppear {
                
            }
        }
    }
}

@Reducer
struct CommonPopupUIFeature {
    struct State: Equatable {
        var titleText:String = ""
        var subText:String = ""
        var imageName:String = ""
        var bottomText:String = ""
        var confirmText:String = ""
        var cancelText:String = ""
    }
    
    enum Action: Equatable {
        case viewAppeared
        case confirm
        case cancel
    }
    
    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
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



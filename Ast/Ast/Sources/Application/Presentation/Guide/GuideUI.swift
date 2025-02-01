//
//  GuideUI.swift
//  Ast
//
//  Created by 변윤나 on 1/28/25.
//

import SwiftUI
import ComposableArchitecture

struct GuideUI: View {
    let store: StoreOf<GuideUIFeature> = Store(initialState: GuideUIFeature.State()) { GuideUIFeature() }
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack(alignment: .leading, spacing: 0) {
                    
                    NavigationBarView(title: "💫 🔮 💫") {
                        dismiss()
                    }
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(Guide.concept, id: \.self) { item in
                                Text("\(item.title)")
                                    .fontColor(.h1, color: .b1)
                                    .padding(.vertical, 8)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    ForEach(item.contents.contents, id: \.self) { content in
                                        Text("• \(content)")
                                            .fontColor(.h8, color: .b1)
                                            .padding(.vertical, 1)
                                    }
                                    
                                    ForEach(item.contents.subContents, id: \.self) { subContents in
                                        Text("· \(subContents)")
                                            .fontColor(.h8, color: .b1)
                                            .padding(.leading, 4)
                                            .padding(.vertical, -1)
                                        
                                        if subContents == "..." {
                                            Button {
                                                viewStore.send(.houseButtonTapeed)
                                            } label: {
                                                HStack {
                                                    Spacer()
                                                    Text("더 알아보기")
                                                        .fontColor(.c1,color: .white)
                                                    Spacer()
                                                }
                                                .frame(width: 90, height: 35)
                                                .background(.c1)
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                                .padding(.horizontal, 4)
                                            }
                                            Spacer()
                                        }
                                    }
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(height: 26)
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                        Spacer()
                    }
                }
                .onAppear {
                    viewStore.send(.viewAppeared)
                }
            }
        }
    }
}

#Preview {
    GuideUI()
}


@Reducer
struct GuideUIFeature {
    struct State: Equatable {
        //var guide: Guide?
    }
    
    enum Action: Equatable {
        case viewAppeared
        case houseButtonTapeed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared :
                // state.guide = Guide()
                return .none
            case .houseButtonTapeed :
                return .none
            }
        }
    }
}

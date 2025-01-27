//
//  WeeklyUI.swift
//  Ast
//
//  Created by 변윤나 on 1/27/25.
//

import SwiftUI
import ComposableArchitecture

struct WeeklyUI: View {
    let store: StoreOf<HomeFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    
                    Text("🦄")
                        .font(.system(size: 50))
                        .padding(.top, 40)
                    
                    Text("\(viewStore.currentMonthlydate.isCurrentDate())의 n주차 운세를 \n알아 보세요")
                        .fontColor(.s1, color: .b1)
                    Text("(*주간 운세는 광고를 본 후 확인할 수 있어요)")
                    Text("(*주간 운세는 광고를 본 후 확인할 수 있어요)")
                        .fontColor(.tiny1, color: .b1)
                    
                    Button {
                        viewStore.send(.showWeaklyTapped)
                    } label: {
                        HStack {
                            Spacer()
                            Text("광고보고 주간 운세 보기")
                                .fontColor(.h5, color: .white)
                            Spacer()
                        }
                        .frame(height: 50)
                    }
                    .background(.c1)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 20)
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 12)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

//@Reducer
//struct WeeklyUIFeature {
//    struct State: Equatable {
//
//    }
//
//    enum Action: BindableAction, Equatable {
//        case binding(BindingAction<State>)
//        case showTapped
//    }
//
//    var body: some ReducerOf<Self> {
//        BindingReducer()
//
//        Reduce { state, action in
//            switch action {
//            case .binding(_):
//                return .none
//            case .showTapped:
//                return .none
//            }
//        }
//    }
//}

#Preview {
    WeeklyUI(store: Store(initialState: HomeFeature.State(), reducer: { HomeFeature() }))
}

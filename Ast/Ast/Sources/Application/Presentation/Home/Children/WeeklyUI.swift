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
                EmptyWeeklyUI(store: store).isHidden(viewStore.isShowWeekly)
                WeeklyShowUI(store: store).isHidden(!viewStore.isShowWeekly)
            }
            .scrollIndicators(.hidden)
            .background(viewStore.isShowWeekly ? .white : Color(UIColor.systemGroupedBackground))
        }
    }
}

struct EmptyWeeklyUI: View {
    let store: StoreOf<HomeFeature>
    @State private var isPressed = false
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            LazyVStack(alignment: .leading, spacing: 10) {
                
                Text("🦄")
                    .font(.system(size: 50))
                    .padding(.top, 40)
                
                Text("\(viewStore.currentMonthlydate.toMonthDate())의 \(viewStore.currentMonthlydate.toWeekOfmonth())주차 운세를 \n알아 보세요")
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
                            .scaleEffect(isPressed ? 0.9 : 1.0)
                        Spacer()
                    }
                    .frame(height: 50)
                }
                .background(.c1)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}
struct WeeklyShowUI: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            LazyVStack(alignment: .leading, spacing: 20) {
                Text(viewStore.leadWeaks?.title ?? "")
                    .fontColor(.h1, color: .b1)
                ForEach(viewStore.leadWeaks?.acticle ?? [], id: \.self) { item in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(item.subTitle)
                                .fontColor(.h4, color: .b1)
                                .padding(.vertical, 8)
                            ForEach(item.contents, id: \.self) { content in
                                Text("\(content.replaceArrow().boldTextBeforeColon())") //•
                                    .fontColor(.h8, color: .b1)
                                    .padding(.vertical, 1)
                            }
                            
                            ForEach(item.subContents, id: \.self) { subContent in
                                Text("· \(subContent)")
                                    .fontColor(.h8, color: .b1)
                                        .padding(.leading, 4)
                                        .padding(.vertical, -1)
                            }
                        }
                        .padding(12)
                    }
                }
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 30)
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
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

//#Preview {
//    WeeklyUI(store: Store(initialState: HomeFeature.State(), reducer: { HomeFeature() }))
//}

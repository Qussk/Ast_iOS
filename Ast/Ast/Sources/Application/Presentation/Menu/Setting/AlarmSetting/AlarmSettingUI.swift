//
//  AlarmSettingUI.swift
//  Ast
//
//  Created by 변윤나 on 2/3/25.
//

import SwiftUI
import ComposableArchitecture

struct AlarmSettingUI: View {
    let store: StoreOf<AlarmSettingUIFeature> = Store(initialState: AlarmSettingUIFeature.State(), reducer: { AlarmSettingUIFeature() })
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                NavigationBarView(title: "알림설정") {
                    dismiss()
                }
                SettingListItem(
                    type: .alarm(.today),
                    image: "",
                    title: "매일 알림",
                    subTitle: "매일 정해진 시간에 운세 업데이트 알림을 받아요.",
                    value: "\(viewStore.hour.formatTimeUnit()):\(viewStore.minute.formatTimeUnit())",
                    toggle: true
                )
                .onTapGesture {
                    viewStore.send(.selectedMenu(.alarm(.today)))
                }
                //"\(viewStore.hour):\(viewStore.minite)",
                //                SettingListItem(
                //                    type: .alarm(.rank),
                //                    image: "",
                //                    title: "1위때만 알림",
                //                    subTitle: "1위였을때만 알림을 받아요.",
                //                    value: "",
                //                    toggle: true
                //                )
            }
            .onAppear {
                viewStore.send(.viewAppeared)
            }

            Spacer()
            .clearFullScreenCover(store: store.scope(state: \.$timePopup, action: \.timePopup), content: {
                store in
                TimeSelectUI(store: store)
            })
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AlarmSettingUI()
}

@Reducer
struct AlarmSettingUIFeature {
    struct State: Equatable {
        @PresentationState var timePopup: TimeSelectUIFeature.State?
        @BindingState var hour: Int = UserDefaults.alarmHour
        @BindingState var minute: Int = UserDefaults.alarmMinute
    }
    
    enum Action: BindableAction, Equatable {
        case viewAppeared
        case binding(BindingAction<State>)
        case selectedMenu(SettingListItemFeature.ListItemType)
        case timeSelectionPopup
        case timePopup(PresentationAction<TimeSelectUIFeature.Action>)
    }
    

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.$hour):
                return .none
            case .viewAppeared:
                return .none
            case .selectedMenu(let type):
                switch type {
                case let .alarm(alarmType):
                    if alarmType == .today {
                        return .run { await $0(.timeSelectionPopup)}
                    }
                default: break
                }
                return .none
            case .timeSelectionPopup :
                state.timePopup = TimeSelectUIFeature.State()
                return .none
            case .timePopup(.presented(let action)):
                switch action {
                case let .confirm(hour, minute):
                    UserDefaults.alarmHour = hour
                    UserDefaults.alarmMinute = minute
                    state.hour = hour
                    state.minute = minute
                default : break
                }
                
                state.timePopup = nil
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$timePopup, action: \.timePopup) {
            TimeSelectUIFeature()
        }
    }
}

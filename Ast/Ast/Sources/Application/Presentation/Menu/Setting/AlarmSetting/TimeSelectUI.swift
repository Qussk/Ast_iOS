//
//  TimeSelectUI.swift
//  Ast
//
//  Created by 변윤나 on 2/6/25.
//

import SwiftUI
import ComposableArchitecture

struct TimeSelectUI: View {
    let store: StoreOf<TimeSelectUIFeature>
    @State var selectedHour: Int = UserDefaults.alarmHour
    @State var selectedMinute: Int = UserDefaults.alarmMinute

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack{
                Color.black.opacity(0.2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("시간설정")
                                    .fontColor(.h4, color: .black)
                                Text("원하는 시간을 선택해 주세요")
                                    .fontColor(.tiny2, color: .b2)
                            }
                            Spacer()
                            Button {
                                viewStore.send(.confirm(selectedHour, selectedMinute))
                            } label: {
                                Text("완료")
                                    .fontColor(.h7, color: .c1)
                            }
                        }
                        .padding(15)
                        
                        HStack {
                            Picker("", selection: $selectedHour) {
                                ForEach(viewStore.hoursCase, id: \.self) { hour in
                                    Text("\(hour.formatTimeUnit())시").tag(hour)
                                        .fontColor(.h3, color: .black)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            Text(":")

                            Picker("", selection: $selectedMinute) {
                                ForEach(viewStore.minutesCase, id: \.self) { minute in
                                    Text("\(minute.formatTimeUnit())분").tag(minute)
                                        .fontColor(.h3, color: .black)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(.vertical, 0)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 260)
                    .background(Color.white)
                    .cornerRadius(18)
                    .padding(.horizontal, 40)
                    
                    Button {
                        viewStore.send(.cancel)
                    } label: {
                        HStack {
                            Image("close")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("닫기")
                                .fontColor(.h3, color: .gray)
                        }
                    }
                    .padding(.top, 0)
                }
            }
            .ignoresSafeArea()
        }
    }
}


@Reducer
struct TimeSelectUIFeature {
    struct State: Equatable {
        let hoursCase = Array(0...23)
        let minutesCase = Array(stride(from: 0, to: 59, by: 5))
    }
    enum Action: Equatable {
        case viewAppeared
        case confirm(Int, Int)
        case cancel
    }
    
    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case let .confirm(hour, minute):
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

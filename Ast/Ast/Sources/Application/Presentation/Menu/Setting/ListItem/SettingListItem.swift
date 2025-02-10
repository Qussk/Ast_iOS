//
//  SettingListItem.swift
//  Ast
//
//  Created by 변윤나 on 2/5/25.
//

import SwiftUI
import UIKit
import ComposableArchitecture


struct SettingListItem: View {
    let store: StoreOf<SettingListItemFeature> = Store(initialState: SettingListItemFeature.State()) { SettingListItemFeature() }
    var type: SettingListItemFeature.ListItemType
    var image: String
    var title: String
    var subTitle: String
    var value: String
    var toggle: Bool = false
    @State private var isOn = false

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Spacer()
                
                HStack(spacing: 10) {
                    Image(image)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .isHidden(image.isEmpty)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .fontColor(.h5, color: .t1)
                        Text(subTitle)
                            .fontColor(.l1, color: .t1)
                            .isHidden(subTitle.isEmpty)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: 205, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Text(value)
                            .fontColor(.h5, color: .b2)
                            .isHidden(value.isEmpty)
                            .frame(maxWidth: 70, alignment: .trailing)
                        
                        Toggle("", isOn: $isOn)
                            .toggleStyle(SwitchToggleStyle(tint: .c1))
                            .scaleEffect(0.8)
                            .isHidden(!toggle)
                            .frame(width: 40)
                            .padding(.trailing, 12)
                            .onAppear {
                                viewStore.send(.viewAppeared(type))
                                self.isOn = viewStore.isOn
                            }
                            .onChange(of: isOn) { toggle in
                                if type == .alarm(.today) {
                                    viewStore.send(.checkNotificationPermission)
                                }
                                
                                //알림설정
                                guard !(type == .alarm(.today)
                                        && toggle
                                        && !viewStore.isPush) else {
                                    openNotificationSettings()
                                    self.isOn = false
                                    return
                                }

                                viewStore.send(.toggleAction(type, toggle))
                            }
                    }
                }
                .frame(minHeight: 50)
                .padding(.horizontal, 18)
                
                Divider()
                    .background(Color.b4.opacity(1))
                    .padding(.horizontal, 18)
                
                Spacer()
            }
            .frame(maxHeight: 70)
        }
    }
    
    //설정 이동
    func openNotificationSettings() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first,
           let rootViewController = window.rootViewController {
            LocalNotificationHelper.shared.checkAndRequestNotificationPermission(from: rootViewController)
        }
    }
}

@Reducer
struct SettingListItemFeature {
    enum ListItemType: Equatable {
        case allmenu
        case alarm(alarmType?)
        case terms(termsType?)
    }

    enum alarmType {
        case today
//        case rank
    }
    
    enum termsType {
        case personal
        case marketing
    }

    struct State: Equatable {
        var menuType: SystemSetting.MenuType = .alarm
        var isOn: Bool = false
        var isPush: Bool = UserDefaults.isPush
    }

    enum Action: Equatable {
        case viewAppeared(ListItemType)
        case toggleAction(ListItemType, Bool)
        case checkNotificationPermission //푸시권한 체크
        case pushUpdate(Bool)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared(let type):
                switch type {
                case .allmenu:
                    state.isOn = UserDefaults.isDark ? true : false
                case let .alarm(alarmType):
                    if alarmType == .today {
                        state.isOn = UserDefaults.isTodayAlarm ? true : false
                    }
                case let .terms(termsType):
                    break
                }
                return .none
            case let .toggleAction(type, toggle):
                switch type {
                case .allmenu:
                    UserDefaults.isDark = toggle
                    ScreanThemeManager.shared.toggleTheme(toggle: !toggle)
                case let .alarm(alarmType) :
                    guard state.isPush else {
                        state.isOn = false
                        UserDefaults.isTodayAlarm = false
                        return .none }

                    if alarmType == .today {
                        UserDefaults.isTodayAlarm = toggle
                    }
                case let .terms(termsType):
                    break
                }
                return .none
            case .checkNotificationPermission :
                return .run { send in
                    let isPermissionGranted = await LocalNotificationHelper.shared.checkNotificationPermission()
                    await send(.pushUpdate(isPermissionGranted))
                }
            case .pushUpdate(let set):
                UserDefaults.isPush = set
                state.isPush = set
                return .none
            }
        }
    }
}

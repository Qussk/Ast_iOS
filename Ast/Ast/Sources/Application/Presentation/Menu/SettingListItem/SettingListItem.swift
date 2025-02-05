//
//  SettingListItem.swift
//  Ast
//
//  Created by 변윤나 on 2/5/25.
//

import SwiftUI
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
            VStack {
                Spacer()
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 24, height: 24)
                    VStack {
                        Text(title)
                            .fontColor(.h5, color: .t1)
                        Text(subTitle)
                            .fontColor(.l1, color: .t1)
                            .isHidden(subTitle.isEmpty)
                    }
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Text(value)
                            .fontColor(.h3, color: .b2)
                            .isHidden(value.isEmpty)
                            .padding(.trailing, 6)
                        Toggle("", isOn: $isOn)
                            .toggleStyle(SwitchToggleStyle(tint: .c1))
                            .scaleEffect(0.8)
                            .isHidden(!toggle)
                            .onAppear {
                                self.isOn = viewStore.isOn
                            }
                            .onChange(of: isOn) { toggle in
                                viewStore.send(.toggleAction(type, toggle))
                            }
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 18)
                
                Divider()
                    .background(Color.b4.opacity(1))
                    .padding(.horizontal, 18)
            }
        }
    }
}


@Reducer
struct SettingListItemFeature {
    enum ListItemType {
        case allmenu
    }
    struct State: Equatable {
        var menuType: SystemSetting.MenuType = .alarm
        var isOn:Bool = false
    }
    enum Action: Equatable {
        case viewAppeared
        case toggleAction(ListItemType, Bool)
        
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                state.isOn = UserDefaults.isDark ? true : false

                return .none
            case let .toggleAction(type, toggle):
                switch type {
                case .allmenu:
                    UserDefaults.isDark = toggle
                    ScreanThemeManager.shared.toggleTheme(toggle: !toggle)
                }
                return .none
            }
        }
    }
}

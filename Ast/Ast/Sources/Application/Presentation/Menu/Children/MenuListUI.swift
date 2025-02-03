//
//  MenuListUI.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import SwiftUI
import ComposableArchitecture

struct MenuListUI: View {
    enum NaviPath: Hashable {
        case alarm
        case themeColor
        case darkMode
        case terms
        case review
    }

    let store: StoreOf<AllMenuUIFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                NavigationLink(destination: AlarmSettingUI()) {
                    MenuListItem(
                        store: store,
                        image: SystemSetting.MenuType.alarm.imageName,
                        title: SystemSetting.MenuType.alarm.rawValue,
                        subTitle: "",
                        value: "",
                        toggle: false
                    ).navigationBarBackButtonHidden()
                }
                
                MenuListItem(
                    store: store,
                    image: SystemSetting.MenuType.themeColor.imageName,
                    title: SystemSetting.MenuType.themeColor.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: false
                ).navigationBarBackButtonHidden()

                MenuListItem(
                    store: store,
                    image: SystemSetting.MenuType.darkMode.imageName,
                    title: SystemSetting.MenuType.darkMode.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: true
                ).navigationBarBackButtonHidden()

                MenuListItem(
                    store: store,
                    image: SystemSetting.MenuType.terms.imageName,
                    title: SystemSetting.MenuType.terms.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: false
                ).navigationBarBackButtonHidden()

                MenuListItem(
                    store: store,
                    image: SystemSetting.MenuType.review.imageName,
                    title: SystemSetting.MenuType.review.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: false
                ).navigationBarBackButtonHidden()
            }
        }
    }
}


struct MenuListItem: View {
    let store: StoreOf<AllMenuUIFeature>
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
                                viewStore.send(.darkModeToggle(toggle))
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

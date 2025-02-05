//
//  MenuListUI.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import SwiftUI
import ComposableArchitecture

struct MenuListUI: View {
    let store: StoreOf<AllMenuUIFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                NavigationLink(destination: AlarmSettingUI()) {
                    SettingListItem(
                        type: .allmenu,
                        image: SystemSetting.MenuType.alarm.imageName,
                        title: SystemSetting.MenuType.alarm.rawValue,
                        subTitle: "",
                        value: "",
                        toggle: false
                    ).navigationBarBackButtonHidden()
                }
                
                SettingListItem(
                    type: .allmenu,
                    image: SystemSetting.MenuType.themeColor.imageName,
                    title: SystemSetting.MenuType.themeColor.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: false
                ).navigationBarBackButtonHidden()

                SettingListItem(
                    type: .allmenu,
                    image: SystemSetting.MenuType.darkMode.imageName,
                    title: SystemSetting.MenuType.darkMode.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: true
                ).navigationBarBackButtonHidden()

                SettingListItem(
                    type: .allmenu,
                    image: SystemSetting.MenuType.terms.imageName,
                    title: SystemSetting.MenuType.terms.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: false
                ).navigationBarBackButtonHidden()

                SettingListItem(
                    type: .allmenu,
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


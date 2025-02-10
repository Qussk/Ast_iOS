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
                
                Button {
                    viewStore.send(.selectedMenu(.theme))
                } label: {
                    SettingListItem(
                        type: .allmenu,
                        image: SystemSetting.MenuType.theme.imageName,
                        title: SystemSetting.MenuType.theme.rawValue,
                        subTitle: "",
                        value: "",
                        toggle: false
                    ).navigationBarBackButtonHidden()

                }
                
                if viewStore.isTheme {
                    ThemeSelectUI(store: store)
                }

                SettingListItem(
                    type: .allmenu,
                    image: SystemSetting.MenuType.darkMode.imageName,
                    title: SystemSetting.MenuType.darkMode.rawValue,
                    subTitle: "",
                    value: "",
                    toggle: true
                ).navigationBarBackButtonHidden()

                NavigationLink(destination: TermsListUI()) {
                    SettingListItem(
                        type: .allmenu,
                        image: SystemSetting.MenuType.terms.imageName,
                        title: SystemSetting.MenuType.terms.rawValue,
                        subTitle: "",
                        value: "",
                        toggle: false
                    ).navigationBarBackButtonHidden()
                }

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


struct ThemeSelectUI: View {
    let store: StoreOf<AllMenuUIFeature>
    @State private var isValid: Bool?
//    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                VStack(spacing: 10) {
                    HStack(spacing: 8) {
                        ForEach(SystemSetting.ColorType.allCases, id: \.self) { color in
                            Button {
                                viewStore.send(.selectColor(color))
                            } label: {
                                Rectangle()
                                    .fill(color.colors)
                                    .frame(width: 22, height: 22)
                                    .cornerRadius(11)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 11)
                                            .stroke(viewStore.selectColor == color ? Color.blue : Color.bg3, lineWidth: viewStore.selectColor == color ? 3 : 1)
                                    )
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                    
                    HStack(spacing: 8) {
                        Text("Hex: ")
                            .fontColor(.h4, color: .b1)
                        TextField("예시: #E9E9E9", text: viewStore.$hexText)
                            .fontColor(.h5, color: .black)
//                            .focused($isTextFieldFocused)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: viewStore.hexText) { text in
                                if !text.isEmpty {
                                    viewStore.send(.onChangeTextField(text: text))
                                }
                                if text.count == 7 {
                                    hideKeyboard()
                                }
                            }
                            
                            .frame(height: 20)
                    }
                    .padding(.top, 10)
                    
                    
                    if !viewStore.isValid && viewStore.hexText != "" {
                        Text("헥사코드가 아닙니다.")
                            .fontColor(.tiny2, color: .c1)
                            .padding(.leading, 10)
                            .padding(.top, 4)
                            .padding(.bottom, 10)
                    }
                }
                .padding(.horizontal, 30)
                .onTapGesture(perform: {
                    hideKeyboard()
                })
//                .onAppear {
//                    isTextFieldFocused = true
//                }
            }
        }
    }
}

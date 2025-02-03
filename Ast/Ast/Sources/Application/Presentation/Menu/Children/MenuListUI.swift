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
                ForEach(SystemSetting.MenuType.allCases, id: \.self) { option in
                    MenuListItem(store: store,
                                 option: option
                                 )
                    .onTapGesture {
                        viewStore.send(.selectedMenu(option))
                    }
                }
            }
        }
    }
}


struct MenuListItem: View {
    let store: StoreOf<AllMenuUIFeature>
    var option: SystemSetting.MenuType

    @State private var isOn = false

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            VStack {
                Spacer()
                HStack {
                    Image(option.imageName)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(option.rawValue)
                        .fontColor(.h5, color: .t1)
                    Spacer()
                    
                    
                    Toggle(viewStore.darkModeText, isOn: $isOn)
                        .frame(minWidth: 50, maxWidth: 100, alignment: .trailing)
                        .fontColor(.h3, color: .b2)
                        .toggleStyle(SwitchToggleStyle(tint: .c1))
                        .scaleEffect(0.8)
                        .isHidden(!(option == .darkMode))
                        .onAppear {
                            self.isOn = viewStore.isOn
                        }
                        .onChange(of: isOn) { toggle in
                            viewStore.send(.darkModeToggle(toggle))
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

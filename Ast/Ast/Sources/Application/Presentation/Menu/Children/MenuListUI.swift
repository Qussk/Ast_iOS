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
                    VStack {
                        Spacer()
                        HStack {
                            Text(option.rawValue)
                                .fontColor(.h5, color: .t1)
                            Spacer()
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
    }
}

//#Preview {
//    MenuListUI()
//}

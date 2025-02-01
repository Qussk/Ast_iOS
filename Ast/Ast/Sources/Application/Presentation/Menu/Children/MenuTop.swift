//
//  MenuTop.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import SwiftUI
import ComposableArchitecture

struct MenuTop: View {
    let store: StoreOf<AllMenuUIFeature>
   
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 10) {
                    ZStack {
                        HStack(spacing: 10) {
                            MenuTopItem(atrNm: viewStore.astroNm)
                            Text("asdsdasdasdasd")
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
                    .frame(height: 90)
                    .background(Color.bg1)
                    .padding(.horizontal, 10)
                }
                .padding(.top, 10)
                .padding(.horizontal, 18)
                Spacer()
            }
            Spacer()
        }
    }
}

struct MenuTopItem: View {
    var atrNm = ""
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 44, height: 44)
                .cornerRadius(22)
            Text(atrNm.getEmoji())
                .frame(width: 24, height: 24)
        }
        .padding(.leading, 10)
    }
}

//
//  MenuCreditUI.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import SwiftUI
import ComposableArchitecture

struct MenuCreditUI: View {
    let store: StoreOf<AllMenuUIFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 8) {
                
                MenuCreditPremiumItem()
                    .onTapGesture {
                        print("프리미엄 전환 화면")
                    }
                
                VStack(spacing: 8) {
                    MenuCreditDonationItem(amount: viewStore.amount)
                    MenuCreditRankItem(rank: viewStore.rank)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
        }
    }
}


struct MenuCreditPremiumItem: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(.b4, lineWidth: 1)
                .frame(height: 110)
            
            VStack(alignment: .leading) {
                HStack(spacing: 6) {
                    Text("프리미엄 전환혜택")
                        .fontColor(.h7, color: .t1)

                    Text("premium")
                        .padding(.horizontal, 8)
                        .frame(height: 20, alignment: .leading)
                        .background(Color.c7)
                        .fontColor(.c2, color: .white)
                        .cornerRadius(10)
                }
                .padding(.top, 8)
                .padding(.bottom, 2)

                VStack(alignment: .leading) {
                    Text("· 프리미엄~")
                        .fontColor(.tiny2, color: .b1)
                    Text("· 프리미엄123123~")
                        .fontColor(.tiny2, color: .b1)
                    Text("· 프리미엄123123~ㄴㅇㅁ")
                        .fontColor(.tiny2, color: .b1)
                }
                .padding(.top, 0)
                .padding(.bottom, 15)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
        }
    }
}

struct MenuCreditDonationItem: View {
    var amount: Int = 0
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(.b4, lineWidth: 1)
                .frame(width: 90, height: 51)
            
            VStack(spacing: 4) {
                Text("보유 복채")
                    .fontColor(.c1, color: .t1)
                    .padding(.top, 2)
                HStack {
                    Image("money")
                        .resizable()
                        .frame(width: 22,height: 22)
                    Text("\(amount)")
                        .fontColor(.l2, color: .b1)
                        .padding(.leading, -2)
                }
            }
        }
    }
}

struct MenuCreditRankItem: View {
    var rank: Int = 0
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(.b4, lineWidth: 1)
                .frame(width: 90, height: 51)
            
            VStack(spacing: 4) {
                Text("나의 순위")
                    .fontColor(.c1, color: .t1)
                    .padding(.top, 2)
                HStack {
                    Text(rank.getTopRank(default: true))
                        .frame(width: 22,height: 22)
                    Text("\(rank)위")
                        .fontColor(.l2, color: .b1)
                        .padding(.leading, -4)
                }
            }
        }

    }
}

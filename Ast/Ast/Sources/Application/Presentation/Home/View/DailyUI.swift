//
//  DailyItemUI.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture

//MARK: 컨텐츠 - 일일
struct DailyUI: View {
    let store: StoreOf<HomeFeature> = Store(initialState: HomeFeature.State()) { HomeFeature() }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewStore.leadDays, id: \.self) { item in
                        LazyVStack {
                            DailyItemUI(
                                rank: item.rank,
                                name: item.astroNm.getNameDescription(),
                                text: item.content,
                                img: item.astroNm.getEmoji(),
                                key: item.luckyKey,
                                color: item.luckyColor,
                                food: item.luckyFood,
                                word: item.luckyWord
                            )
                            .padding(.horizontal, 18)
                            .onTapGesture {
                                
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                .onAppear(){
                    viewStore.send(.setDailyLead)
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}


struct DailyItemUI: View {
    let rank: Int
    let name: String
    let text: String
    let img: String
    let key: String
    let color: String
    let food: String
    let word: String

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .bottom, spacing: 10) {
                    Text("\(rank)위")
                        .fontColor(.h4, color: .b1)
                        .multilineTextAlignment(.leading)
                    Text(name)
                        .fontColor(.h1, color: .b1)
                    Text(img)
                        .font(.system(size: 24))
                    Spacer()
                    Text("\(rank.getTopRank())")
                        .font(.system(size: 24))
                        .multilineTextAlignment(.trailing)
                }
                
                Text(text)
                    .fontColor(.h7, color: .b1)
                    .lineSpacing(5)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 8)
                
                HStack(spacing: 0) {
                    Text("행운의 열쇠 : ")
                        .fontColor(.h6, color: .b1)
                    Text(key)
                        .fontColor(.h7, color: .b1)
                    Spacer()
                    
                    Text("행운의 컬러 : ")
                        .fontColor(.h6, color: .b1)
                    Text(color)
                        .fontColor(.h7, color: .b1)
                }
                .padding(.top, 12)
                .padding(.trailing, 36)
                .multilineTextAlignment(.leading)
                
                HStack(spacing: 0) {
                    Text("행운의 음식 : ")
                        .fontColor(.h6, color: .b1)
                    Text(food)
                        .fontColor(.h7, color: .b1)
                    Spacer()
                    
                    Text("행운의 자음 : ")
                        .fontColor(.h6, color: .b1)
                    Text(word)
                        .fontColor(.h7, color: .b1)
                }
                .padding(.top, -4)
                .padding(.trailing, 36)
                .multilineTextAlignment(.leading)
                
                DailyItemLikeUI()
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DailyItemLikeUI: View {
    let store: StoreOf<HomeFeature> = Store(initialState: HomeFeature.State()) { HomeFeature() }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 12) {
                Button {
                    viewStore.send(.toShareTapped)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                }
                Button {
                    viewStore.send(.toDownloadTapped)
                } label: {
                    Image(systemName: "arrow.down.to.line")
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                }
                Button {
                    viewStore.send(.toLikeTapped)
                } label: {
                    Image(systemName: viewStore.isLikeImagenamed)
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 10)
        }
    }
}

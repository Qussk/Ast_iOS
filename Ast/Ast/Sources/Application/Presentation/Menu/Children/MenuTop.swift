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
    @State private var progress: CGFloat = 0.25
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("#기본 님")
                        .fontColor(.h1, color: .t1)
                    HStack(spacing: 10) {
                        MenuTopItem(atrNm: viewStore.astroNm)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 10) {
                                Image("female32")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .padding(.leading, 10)
                                Text("생년월일")
                                    .fontColor(.h5, color: .t1)
                                    .underline()
                                Spacer()
                            }
                            HStack(spacing: 10) {
                                Text("출생지")
                                    .fontColor(.h5, color: .t1)
                                    .underline()
                                Text("태어난 시")
                                    .fontColor(.h5, color: .t1)
                                    .underline()
                            }
                        }
                        
                        Spacer()
                        
                        CircularGaugeView(progress: progress)
                            .padding()
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 18)
            }
        }
    }
}

struct MenuTopItem: View {
    var atrNm = ""
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 46, height: 46)
                .cornerRadius(23)
            
            Text(atrNm.getEmoji())
                .font(.system(size: 24))
                .frame(width: 24, height: 24)
            
            Text(atrNm.getSymbol())
                .font(.system(size: 12))
                .padding(6)
                .offset(x: 18, y: 15)
        }
        .padding(.trailing, 16)
        .padding(.leading, 10)
    }
}

struct CircularGaugeView: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(Color.gray.opacity(0.3))
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(.red)
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .fontColor(.c3, color: .b2)
        }
        .frame(width: 50, height: 50)
    }
}

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
    let data = [
        ("짧은 텍스트", "🐑"),
        ("중간 길이의 텍스트입니다.", "🐮"),
        ("이 텍스트는 꽤나 길어서 셀의 높이가 동적으로 늘어나야 합니다. 여러 줄에 걸쳐서 렌더링되는 것을 확인해 보세요.","🏹")
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(data, id: \.0) { item in
                    ASTItemUI(text: item.0, imageString: item.1)
                        .padding(.horizontal, 18)
                }
            }
            .padding(.vertical, 10)
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}


struct ASTItemUI: View {
    let text: String
    let imageString: String

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(imageString)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.leading)
                Text(text)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
    }
}

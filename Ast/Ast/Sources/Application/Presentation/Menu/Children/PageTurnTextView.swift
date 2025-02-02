//
//  PageTurnTextView.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import SwiftUI

struct PageTurnTextView: View {
    let texts: [String]
    let duration: Double
    @State private var currentIndex = 0
    @State private var isCollapsed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: 34)
                .rotation3DEffect(
                    .degrees(isCollapsed ? 90 : 0),
                    axis: (x: 1, y: 0, z: 0), // X축을 기준으로 회전
                    anchor: .center
                )
                .animation(Animation.easeInOut(duration: 0.5).repeatCount(1, autoreverses: false), value: isCollapsed)
                .onAppear {
                    startPageTurnAnimation()
                }
            
            Text(texts[currentIndex])
                .fontColor(.l1, color: .b1)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding(.top, 20)
        //.padding(.bottom, 10)
    }

    private func startPageTurnAnimation() {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            isCollapsed.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // 애니메이션 후 텍스트 변경
                currentIndex = (currentIndex + 1) % texts.count
                isCollapsed.toggle() // 펼치기
            }
        }
    }
}

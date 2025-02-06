//
//  HouseUI.swift
//  Ast
//
//  Created by 변윤나 on 2/3/25.
//

import SwiftUI

struct HouseUI: View {
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.bg1
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                NavigationBarView(title: "🌟 12 House 🌌") {
                    dismiss()
                }
                .zIndex(1)
                
                ZStack {
                    Image("background5")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: screenWidth, maxHeight: screenHeight - (statusBarHeight + statusbottomBarHeight + 52))
                        .clipped()
                    Color.black.opacity(0.3)
                    
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(Guide.house, id: \.self) { item in
                                Text("\(item.title)")
                                    .fontColor(.h2, color: .white)
                                    .padding(.vertical, 8)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    ForEach(item.contents.contents, id: \.self) { content in
                                        Text("\(content)")
                                            .fontColor(.h4, color: .white)
                                            .padding(.vertical, 1)
                                    }
                                    
                                    ForEach(item.contents.subContents, id: \.self) { subContents in
                                        Text("\(subContents)")
                                            .fontColor(.h8, color: .white)
                                            .padding(.leading, 4)
                                            .padding(.vertical, -1)
                                        
                                    }
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(height: 26)
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                        Spacer()
                    }
                    .padding(.bottom, 6)
                }
                .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    HouseUI()
}

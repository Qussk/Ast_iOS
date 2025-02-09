//
//  NavigationBarView.swift
//  Ast
//
//  Created by 변윤나 on 1/28/25.
//

import SwiftUI

struct NavigationBarView: View {
    private let title: String
    private var isUnderlineHidden = true
    private var isWhite: Bool = false
    private var action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.init(title: title, isUnderlineHidden: true, action: action)
    }
    
    init(title: String, isUnderlineHidden: Bool, action: @escaping () -> Void) {
        self.title = title
        self.isUnderlineHidden = isUnderlineHidden
        self.action = action
    }
    
    init(title: String, isWhite: Bool, action: @escaping () -> Void) {
        self.title = title
        self.isWhite = isWhite
        self.action = action
    }

    var body: some View {
        ZStack {
            if !title.isEmpty {
                HStack {
                    Spacer()
                    
                    Text(title)
                        .fontColor(.h4, color: isWhite ? .white : .b1)
                    
                    Spacer()
                }
                .frame(height: 48)
            }
            
            if !isUnderlineHidden {
                VStack {
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.b4)
                        .frame(height: 1)
                }
                .frame(height: 48)
            }
            
            HStack {
                Button {
                    action()
                } label: {
                    Image("ico_appbar_back")
                        .tint(isWhite ? .white : .b1)
                }
                .padding(.leading, 18)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationBarView(title: "navigation title") {
        
    }
    .background(Color.red.opacity(0.2))
}

//
//  InfomationUI.swift
//  Ast
//
//  Created by 변윤나 on 1/28/25.
//

import SwiftUI

struct GuideUI: View {

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                NavigationBarView(title: "💫 🔮 💫") {
                    dismiss()
                }
                
                Text("Hello, GuideUI!")
                Spacer()
            }
        }
        
    }
}

#Preview {
    GuideUI()
}

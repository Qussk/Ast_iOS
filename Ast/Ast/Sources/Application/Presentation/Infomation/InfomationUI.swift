//
//  InfomationUI.swift
//  Ast
//
//  Created by 변윤나 on 1/28/25.
//

import SwiftUI

struct InfomationUI: View {

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                NavigationBarView(title: "💫 🔮 💫") {
                    dismiss()
                }
                
                Text("Hello, InfomationUI!")
                Spacer()
            }
        }
        
    }
}

#Preview {
    InfomationUI()
}

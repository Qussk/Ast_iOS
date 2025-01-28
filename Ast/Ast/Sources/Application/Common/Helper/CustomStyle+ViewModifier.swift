//
//  CustomStyle+ViewModifier.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI

struct FontColor: ViewModifier {
    var textColor: Color
    var font: Font
    var backgroundColor: Color?
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .font(font)
            .background(backgroundColor == nil ? .clear : backgroundColor)
    }
}

struct Colors: ViewModifier {
    var foregroundColor: Color
    var backgroundColor: Color?
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .background(backgroundColor == nil ? .clear : backgroundColor)
    }
}

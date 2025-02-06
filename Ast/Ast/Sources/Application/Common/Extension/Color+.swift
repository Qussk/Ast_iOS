//
//  Color+.swift
//  Ast
//
//  Created by 변윤나 on 2/6/25.
//
import SwiftUI

extension Color {
    /// Color를 Hex 문자열로 변환하는 함수
    func toHex() -> String {
        let uiColor = UIColor(self)
        let components = uiColor.cgColor.components ?? [0, 0, 0, 1]
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        let a = Int(components[3] * 255)
        
        return String(format: "#%02X%02X%02X%02X", r, g, b, a)
    }
    
    /// Hex 문자열을 Color로 변환하는 함수
    static func fromHex(hex: String) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized = String(hexSanitized.dropFirst())
        }
        
        guard hexSanitized.count == 8, let rgbValue = Int(hexSanitized, radix: 16) else {
            return .clear
        }
        
        let r = Double((rgbValue >> 24) & 0xFF) / 255.0
        let g = Double((rgbValue >> 16) & 0xFF) / 255.0
        let b = Double((rgbValue >> 8) & 0xFF) / 255.0
        let a = Double(rgbValue & 0xFF) / 255.0
        
        return Color(red: r, green: g, blue: b, opacity: a)
    }
}

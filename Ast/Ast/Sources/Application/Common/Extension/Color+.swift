//
//  Color+.swift
//  Ast
//
//  Created by 변윤나 on 2/6/25.
//
import SwiftUI

extension Color {
    ///Alpha 값 없음.
    /// Color를 Hex 문자열로 변환하는 함수
    func toHex() -> String {
        let uiColor = UIColor(self)
                
                guard let components = uiColor.cgColor.components else {
                    return "#F19A37" // 기본값
                }

                let r: Int, g: Int, b: Int
                if components.count >= 3 {
                    r = Int(components[0] * 255)
                    g = Int(components[1] * 255)
                    b = Int(components[2] * 255)
                } else {
                    r = Int(components[0] * 255)
                    g = r
                    b = r
                }
        
                return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    /// Hex 문자열을 Color로 변환하는 함수
    static func fromHex(hex: String) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
                // # 제거
                if hexSanitized.hasPrefix("#") {
                    hexSanitized = String(hexSanitized.dropFirst())
                }
                
                // 6자리 헥사코드인지 확인
                guard hexSanitized.count == 6, let rgbValue = Int(hexSanitized, radix: 16) else {
                    return .clear
                }
                
                // RGB 값 추출
                let r = Double((rgbValue >> 16) & 0xFF) / 255.0
                let g = Double((rgbValue >> 8) & 0xFF) / 255.0
                let b = Double(rgbValue & 0xFF) / 255.0
                
                return Color(red: r, green: g, blue: b) // Alpha 값 없이 반환
    }
}

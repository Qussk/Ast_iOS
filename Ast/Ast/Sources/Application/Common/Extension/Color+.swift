//
//  Color+.swift
//  Ast
//
//  Created by 변윤나 on 2/6/25.
//
import SwiftUI


extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0.7...1),
            green: .random(in: 0.7...1),
            blue: .random(in: 0.8...1)
        )
    }
    
    
    /// 저장된 랜덤 컬러를 저장함
    static func saveToStorage(color: Color) -> Data? {
        let uiColor = UIColor(color)
        guard let colorData = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false) else {
            return nil
        }
        return colorData
    }

    /// 저장된 Data에서 색을 불러옴
    static func getStoredColor(from colorData: Data?) -> Color {
        guard let colorData = colorData,
              let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) else {
            return Color.random // 저장된 데이터가 없다면 랜덤 컬러 반환
        }
        return Color(uiColor)
    }
}

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

//
//  Number.swift
//  Ast
//
//  Created by 변윤나 on 1/27/25.
//
import UIKit
import SwiftUI

let screenSize = UIScreen.main.bounds.size
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let statusBarHeight = UIApplication.topSafeAreaHeight
let statusbottomBarHeight = UIApplication.bottomSafeAreaHeight




func colorFromHex(hex: String) -> Color? {
    let cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
    
    guard cleanedHex.count == 6, let hexValue = Int(cleanedHex, radix: 16) else {
        return nil
    }
    
    /// RGB 구성 요소 추출
    let red = Double((hexValue >> 16) & 0xFF) / 255.0
    let green = Double((hexValue >> 8) & 0xFF) / 255.0
    let blue = Double(hexValue & 0xFF) / 255.0
    
    return Color(red: red, green: green, blue: blue)
}

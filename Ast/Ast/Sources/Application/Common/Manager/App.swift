//
//  App.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//
import Foundation
import Combine
import UIKit


final class App {
    static let shared = App()
    
    @Published private(set) var mainMenuToggle: Void = Void()
    @Published private(set) var goReportScreen: Void = Void()

}

// MARK: - Main Menu Control
extension App {
    func toggleMainMenu() {
        mainMenuToggle = Void()
    }
    
    func toReportScreen() {
        goReportScreen = Void()
    }
}

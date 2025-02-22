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

    public let regionCode = Locale.current.region?.identifier ?? "US"
    private var deviceModelName: String = ""
    @Published private(set) var leadType: LeadType = .daily
    @Published private(set) var mainMenuToggle: Void = Void()
    @Published private(set) var goCalendarToggle: Void = Void()
    
    init() {
    }
}

// MARK: - Main Menu Control
extension App {
    func toggleMainMenu() {
        leadType = .daily
        mainMenuToggle = Void()
    }
    
    func toReportScreen() {
        goCalendarToggle = Void()
    }
    
}

extension App {
    func getDeviceModelName() -> String {
        
        guard deviceModelName == "" else {
            return deviceModelName
        }
        
        if let name = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] {
            deviceModelName = "SIMULATOR - \(name)"
        } else {
            
            let selName = "_\("deviceInfo")ForKey:"
            let selector = NSSelectorFromString(selName)
            
            if UIDevice.current.responds(to: selector) {
                deviceModelName = String(describing: UIDevice.current.perform(selector, with: "marketing-name").takeRetainedValue())
            }
        }
        
        return deviceModelName
    }
    
    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
}

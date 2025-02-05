//
//  UserDefaults+.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import Foundation



extension UserDefaults {
    @UserDefaultsWrapper(key: "isDark", defaultValue: ScreanThemeManager.shared.isDarkMode)
    static var isDark: Bool
    
    @UserDefaultsWrapper(key: "isTodayAlarm", defaultValue: false)
    static var isTodayAlarm: Bool

    @UserDefaultsWrapper(key: "isRankAlarm", defaultValue: false)
    static var isRankAlarm: Bool

}

// MARK: - UserDefaults Wrapper

@propertyWrapper
struct UserDefaultsWrapper<Value> {
    let key: String
    let defaultValue: Value
    let userDefaults = UserDefaults.standard
    
    var wrappedValue: Value {
        get {
            return userDefaults.value(forKey: key.sha1()) as? Value ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key.sha1())
            userDefaults.synchronize()
        }
    }
}

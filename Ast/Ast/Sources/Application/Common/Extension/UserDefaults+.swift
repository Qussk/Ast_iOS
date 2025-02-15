//
//  UserDefaults+.swift
//  Ast
//
//  Created by 변윤나 on 2/2/25.
//

import SwiftUI


extension UserDefaults {
    //설정
    @UserDefaultsWrapper(key: "isDark", defaultValue: ScreanThemeManager.shared.isDarkMode)
    static var isDark: Bool
    
    @UserDefaultsWrapper(key: "isPush", defaultValue: false)
    static var isPush: Bool

    @UserDefaultsWrapper(key: "isTodayAlarm", defaultValue: false)
    static var isTodayAlarm: Bool
    
    @UserDefaultsWrapper(key: "alarmHour", defaultValue: 7)
    static var alarmHour: Int

    @UserDefaultsWrapper(key: "alarmMinute", defaultValue: 45)
    static var alarmMinute: Int

    @UserDefaultsWrapper(key: "myColor", defaultValue: "#F19A37")
    static var myColor: String
    
    @UserDefaultsWrapper(key: "isSignUp", defaultValue: false)
    static var isSignUp: Bool

    @UserDefaultsWrapper(key: "timeStemp", defaultValue: "")
    static var timeStemp: String
    
    @UserDefaultsWrapper(key: "userBirth", defaultValue: "")
    static var userBirth: String

    @UserDefaultsWrapper(key: "userGender", defaultValue: 0)
    static var userGender: Int
    
    @UserDefaultsWrapper(key: "userTime", defaultValue: "")
    static var userTime: String

    @UserDefaultsWrapper(key: "userRegion", defaultValue: "")
    static var userRegion: String

    @UserDefaultsWrapper(key: "editCount", defaultValue: 0)
    static var editCount: Int

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

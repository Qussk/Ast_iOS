//
//  AppDelegate.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import CoreData
import Combine
import ComposableArchitecture
import UserNotifications

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
    var cancellable = Set<AnyCancellable>()
    
    func saveContext() {
        CoreDataStack.shared.saveContext()
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = .black
        window?.overrideUserInterfaceStyle = UserDefaults.isDark ? .dark : .light

        resetRootViewController(rootVc: UIHostingController(rootView: SplashUI()))

        UNUserNotificationCenter.current().delegate = self

        LocalNotificationHelper.shared.setAuthorization { granted in
            let alarmHour = UserDefaults.alarmHour
            let alarmMinute = UserDefaults.alarmMinute

            if granted {
                LocalNotificationHelper.shared.pushNotificationToday(hour: alarmHour, minute: alarmMinute)
                UserDefaults.isTodayAlarm = true
            } else {
                UserDefaults.isTodayAlarm = false
            }
        }
        
        application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)

        return true
    }

}


extension AppDelegate {
    func resetRootViewController(rootVc: UIViewController? = MainTabBarController()) {
        self.window?.rootViewController = rootVc
        self.window?.makeKeyAndVisible()
    }
}

//MARK: Push
extension AppDelegate: UNUserNotificationCenterDelegate {

    func setAuthorization() {
        LocalNotificationHelper.shared.setAuthorization { granted in
            let alarmHour = UserDefaults.alarmHour
            let alarmMinute = UserDefaults.alarmMinute

            if granted {
                LocalNotificationHelper.shared.pushNotificationToday(hour: alarmHour, minute: alarmMinute)
                UserDefaults.isTodayAlarm = true
            } else {
                UserDefaults.isTodayAlarm = false
            }
        }
    }
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
    }
    
    //푸시 탭
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 didReceive response: UNNotificationResponse,
                                 withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }


    // 백그라운드에서 데이터를 가져오는 작업
    func application(
        _ application: UIApplication,
        performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        print("fetch")
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        let currentMinute = Calendar.current.component(.minute, from: Date())
        let alarmHour = UserDefaults.alarmHour
        let alarmMinute = UserDefaults.alarmMinute

        if currentHour == alarmHour && currentMinute == alarmMinute {
            LocalNotificationHelper.shared.pushNotificationToday(hour: alarmHour, minute: alarmMinute)
        }
        
        // fetch가 성공적으로 완료되었음을 알려줌
        completionHandler(.newData)
    }

}

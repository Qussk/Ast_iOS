//
//  LocalNotificationHelper.swift
//  Ast
//
//  Created by 변윤나 on 2/5/25.
//

import UserNotifications
import UIKit


class LocalNotificationHelper {
    static let shared = LocalNotificationHelper()
    
    private init() { }
    
    ///권한 요청
    func setAuthorization(completion: @escaping (Bool) -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {  granted, error in
                if let error = error {
                    print("푸시 권한 요청 실패: \(error.localizedDescription)")
                    UserDefaults.isPush = false
                    completion(false)
                    return
                }
                print("푸시 권한: \(granted ? "허용" : "거부")")
                UserDefaults.isPush = granted
                completion(granted)
            }
        )
    }
    
    ///권한상태 체크
    func checkNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    completion(true)
                case .denied, .notDetermined:
                    completion(false)
                @unknown default:
                    completion(false)
                }
            }
        }
    }
    
    func checkNotificationPermission() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return true
        case .denied, .notDetermined:
            return false
        @unknown default:
            return false
        }
    }

    
    /// 설정 화면으로 이동
    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
    }

    /// 푸시 초기화
    func removeScheduledPush() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["today_push"])
    }
    
    ///매일 알림 설정 푸쉬
    func pushNotificationToday(hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "두근두근 운세 도착 👀"
        content.body = "🏅오늘은 어떤 행운이 왔는지 볼까요?😉"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "today_push", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("푸시 알림 등록 실패: \(error.localizedDescription)")
            }
        }
    }
    
    /// 🚨 알림 권한 확인 후, 거부된 경우 설정 화면으로 이동할지 팝업 표시
    func checkAndRequestNotificationPermission(from viewController: UIViewController) {
        checkNotificationPermission { granted in
            if !granted {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(
                        title: "알림이 꺼져 있어요 ⚠️",
                        message: "앱에서 알림을 받으려면 설정에서 푸시 알림을 활성화해주세요.",
                        preferredStyle: .alert
                    )

                    let settingsAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
                        self.openAppSettings()
                    }
                    let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

                    alertController.addAction(settingsAction)
                    alertController.addAction(cancelAction)
                    UserDefaults.isPush = false
                    viewController.present(alertController, animated: true)
                }
            }
        }
    }
}



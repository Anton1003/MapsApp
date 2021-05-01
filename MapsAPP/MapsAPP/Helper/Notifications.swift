//
//  Notifications.swift
//  MapsAPP
//
//  Created by User on 01.05.2021.
//

import Foundation
import UserNotifications

final class Notifications {
    private let center = UNUserNotificationCenter.current()

    func configNotification() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else {
                print("Разрешение не получено")
                return
            }
        }

        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.sendNotificationRequest(
                    content: self.makeNotificationContent(),
                    trigger: self.makeIntervalNotificationTrigger()
                )
            case .denied:
                print("Разрешения нет")
            case .notDetermined:
                print("Хер пойми")
            case .provisional:
                print("???")
            case .ephemeral:
                print("???")
            @unknown default:
                print("???")
            }
        }
    }

    private func makeIntervalNotificationTrigger() -> UNNotificationTrigger {
        UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    }

    private func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Хочешь на клубнику?"
        content.subtitle = "Тогда запуши в мастер"
        content.body = "И следующим рейсом в Польшу"
        content.badge = 4
        return content
    }

    private func sendNotificationRequest(content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

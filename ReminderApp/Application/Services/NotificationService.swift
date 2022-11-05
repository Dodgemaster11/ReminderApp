//
//  NotificationService.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 26.10.2022.
//

import Foundation
import UserNotifications

protocol NotificationServiceContext {
    func createNotification(notificationData: ReminderData)
    func testNotification()
}

class NotificationService: NotificationServiceContext {
    enum Constants {
        static let testNotificationTitle = "Hello world"
        static let testNotificationBody = "It's a test notification"
        static let notificationErrorText = "Error occured"
    }

    func createNotification(notificationData: ReminderData) {
        DispatchQueue.main.async {
            dataModel.append(notificationData)

            let content = UNMutableNotificationContent()
            content.title = notificationData.title
            content.sound = .default
            content.body = notificationData.body

            let targetDate = notificationData.date
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate),
                                                        repeats: false)
            let request = UNNotificationRequest(identifier: "some_long_id",
                                                content: content,
                                                trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if error != nil {
                    print("error")
                }
            }
        }
    }
    
    func testNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.scheduleTest()
            } else if  error != nil {
                print(Constants.notificationErrorText)
            }
        }
    }
    
    func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = Constants.testNotificationTitle
        content.sound = .default
        content.body = Constants.testNotificationBody
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print(Constants.notificationErrorText)
            }
        }
    }
}

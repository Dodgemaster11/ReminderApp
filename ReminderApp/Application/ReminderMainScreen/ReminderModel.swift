//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import Foundation

protocol ReminderModelProvider {
    func addReminderNote(notificationData: ReminderData)
    func testReminderNote()
}

class ReminderModel: ReminderModelProvider {
    typealias Context = NotificationServiceHolder
    
    private let notificationService: NotificationServiceContext
    
    init(serviceLocator: Context) {
        notificationService = serviceLocator.notificationService
    }
    
    func addReminderNote(notificationData: ReminderData) {
        notificationService.createNotification(notificationData: notificationData)
    }
    
    func testReminderNote() {
        notificationService.testNotification()
    }
}

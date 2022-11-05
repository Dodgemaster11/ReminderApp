//
//  NotificationServiceHolder.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 26.10.2022.
//

import Foundation

protocol NotificationServiceHolder {
    var notificationService: NotificationServiceContext { get }
}

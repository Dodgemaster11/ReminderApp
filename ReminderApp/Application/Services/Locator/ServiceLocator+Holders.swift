//
//  ServiceLocator+Holders.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 26.10.2022.
//

import Foundation

extension ServiceLocator {
    
    private enum Constant {
        static let errorMessage = "'%@' cannot be resolved"
    }
    
    var notificationService: NotificationServiceContext {
        guard let notificationService: NotificationService = self.resolve() else {
            fatalError(.init(format: Constant.errorMessage,
                             arguments: [String(describing: NotificationService.self)]))
            
        }
        return notificationService
    }
}

extension ServiceLocator: NotificationServiceHolder { }

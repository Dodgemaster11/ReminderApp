//
//  ApllicationCoordinator.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    typealias Context = NotificationServiceHolder
    
    private let window: UIWindow
    private let serviceLocator: ServiceLocator
    private let notificationService: NotificationServiceContext
    
    private let rootViewController = UINavigationController()
    
    init(window: UIWindow, serviceLocator: ServiceLocator) {
        self.window = window
        self.window.rootViewController = rootViewController
        self.serviceLocator = serviceLocator
        notificationService = serviceLocator.notificationService
    }
    
    func start() {
        ReminderCoordinator(serviceLocator: serviceLocator, rootViewController: rootViewController).start()
    }
}

//
//  SceneDelegate.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var applicationCoordinator: ApplicationCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            
            let serviceLocator = ServiceLocator()
            registerNotificationService(in: serviceLocator)
            
            let window = UIWindow(windowScene: windowScene)
            let applicationCoordinator = ApplicationCoordinator(window: window, serviceLocator: serviceLocator)
            applicationCoordinator.start()
            
            self.applicationCoordinator = applicationCoordinator
            window.makeKeyAndVisible()
        }
    }
}

extension SceneDelegate {
    private func registerNotificationService(in serviceLocator: ServiceLocator) {
        let notificationService = NotificationService()
        serviceLocator.register(notificationService)
    }
}

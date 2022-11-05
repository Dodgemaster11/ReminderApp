//
//  ReminderCoordinator.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import UIKit

class ReminderCoordinator {
    enum Path {
        case addRemindFlow
    }
    
    private let serviceLocator: ServiceLocator
    private let rootViewController: UINavigationController
    
    init(serviceLocator: ServiceLocator, rootViewController: UINavigationController) {
        self.serviceLocator = serviceLocator
        self.rootViewController = rootViewController
    }
    
    func start() {
        let model = ReminderModel(serviceLocator: serviceLocator)
        let viewModel = ReminderViewModel(model: model) { _ in }
        let viewController = ReminderViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}

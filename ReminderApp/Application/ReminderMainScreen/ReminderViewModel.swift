//
//  ReminderViewModel.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import Foundation
import UserNotifications

protocol ReminderViewModelProvider: AnyObject {
    func onLoad()
    func addTapped(notificationData: ReminderData)
    func testTapped()
}

protocol ReminderViewModelDelegate: AnyObject {
    func presentAlert(title: String, message: String)
}

class ReminderViewModel: ReminderViewModelProvider {
    typealias PathAction = (ReminderCoordinator.Path) -> Void
    
    weak var delegate: ReminderViewModelDelegate?
    
    private let model: ReminderModelProvider
    private let pathAction: PathAction
    
    init(model: ReminderModelProvider, pathAction: @escaping PathAction) {
        self.model = model
        self.pathAction = pathAction
    }
    
    func onLoad() {
        print(#function)
    }
    
    func addTapped(notificationData: ReminderData) {
        model.addReminderNote(notificationData: notificationData)
    }
    
    func testTapped() {
        model.testReminderNote()
    }
}


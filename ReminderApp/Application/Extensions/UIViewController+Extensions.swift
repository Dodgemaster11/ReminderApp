//
//  UIViewController+Extensions.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import UIKit

extension UIViewController {
    public func setUpNavigationBar(navigationController: UINavigationController, barTitle: String, color: UIColor) {
        title = barTitle
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.backgroundColor = appearance.backgroundColor
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
}

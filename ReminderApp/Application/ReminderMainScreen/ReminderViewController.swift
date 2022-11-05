//
//  ReminderViewController.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController {
    enum Constants {
        static let navigationBarTitle = "Reminders"
        static let leftBarButtonName = "Test"
        static let cellReuseId = "cell"
        static let deleteActionTitle = "Delete"
    }
        
    private let viewModel: ReminderViewModelProvider
    
    private lazy var remindersTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReminderCell.self, forCellReuseIdentifier: Constants.cellReuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(viewModel: ReminderViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpAutoLayoutConstraints()
    }
}

extension ReminderViewController {
    func setUpSubviews() {
        guard let navigationController = navigationController else { return }
        setUpNavigationBar(navigationController: navigationController, barTitle: Constants.navigationBarTitle, color: .systemIndigo)
        setUpNavigationItems()
        view.backgroundColor = .systemBackground
        view.addSubview(remindersTable)
    }
    
    func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            remindersTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            remindersTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            remindersTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            remindersTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setUpNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.leftBarButtonName,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(testButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func addButtonTapped() {
        let controller = AddReminderViewController()
        controller.actionClosure = { data in
            switch data {
            case .none: break
            case .some(let notificationData):
                self.viewModel.addTapped(notificationData: notificationData)
                self.remindersTable.reloadData()
            }
        }
        present(controller, animated: true)
    }
    
    @objc func testButtonTapped() {
        viewModel.testTapped()
    }
}

extension ReminderViewController: ReminderViewModelDelegate {
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

extension ReminderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: Constants.deleteActionTitle) { _,_,_ in
            dataModel.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}

extension ReminderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseId, for: indexPath)
        cell.textLabel?.text = dataModel[indexPath.row].title
        
        return cell
    }
}

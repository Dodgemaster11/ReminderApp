//
//  AddReminderViewController.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import UIKit

class AddReminderViewController: UIViewController {
    typealias AddReminderCompletion = (ReminderData?) -> Void
    
    enum Constants {
        static let popUpTitle = "Add Reminder"
        static let rightNavigationBarItemName = "Save"
        static let titleTextFieldPlaceholder = "Enter Title..."
        static let bodyTextFieldPlaceholder = "Enter reminder..."
        static let backButtonTitle = "Back"
        static let saveButtonTitle = "Add"
        
        enum Layout {
            static let titleLabelFontSize = 25.0
            static let stackViewSpacingConstant = 20.0
            static let titleLabelTopAncorConstant = 20.0
            static let mainStackViewTopAncorConstant = 30.0
            static let textFieldsHeightAncorConstant = 52.0
            static let buttonsWidthAncorConstant = 50.0
            static let buttonsStackViewHeightConstant = 50.0
            static let titleFieldTopAncorConstant = 20.0
            static let textFieldsLeadingAncorConstant = 20.0
            static let alpha = 0.35
            static let cornerRadius = 10.0
        }
    }
        
    var actionClosure: AddReminderCompletion?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.popUpTitle
        label.font = UIFont(name: "Helvetica", size: Constants.Layout.titleLabelFontSize)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var titleField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.titleTextFieldPlaceholder
        textField.backgroundColor = .secondarySystemBackground
        textField.borderStyle = .line
        
        return textField
    }()
    
    private lazy var bodyField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.bodyTextFieldPlaceholder
        textField.backgroundColor = .secondarySystemBackground
        textField.borderStyle = .line
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .secondarySystemBackground
        
        return datePicker
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.backButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.cornerRadius = Constants.Layout.cornerRadius
        
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.saveButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = Constants.Layout.cornerRadius
        
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, saveButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        stackView.spacing = Constants.Layout.stackViewSpacingConstant
        
        return stackView
    }()
    
    private lazy var mainAddReminderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleField, bodyField, datePicker, buttonsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemIndigo
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.Layout.stackViewSpacingConstant
        stackView.layer.cornerRadius = Constants.Layout.cornerRadius
        
        return stackView
    }()
    
    init() {
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

extension AddReminderViewController {
    func setUpSubviews() {
        view.backgroundColor = .black.withAlphaComponent(Constants.Layout.alpha)
        view.addSubview(mainAddReminderStackView)
    }
    
    func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            mainAddReminderStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainAddReminderStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: mainAddReminderStackView.topAnchor, constant: Constants.Layout.titleLabelTopAncorConstant),
            titleLabel.centerXAnchor.constraint(equalTo: mainAddReminderStackView.centerXAnchor),
            
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Layout.titleFieldTopAncorConstant),
            titleField.heightAnchor.constraint(equalToConstant: Constants.Layout.textFieldsHeightAncorConstant),
            titleField.leadingAnchor.constraint(equalTo: mainAddReminderStackView.leadingAnchor,
                                                constant: Constants.Layout.textFieldsLeadingAncorConstant),
            
            bodyField.heightAnchor.constraint(equalToConstant: Constants.Layout.textFieldsHeightAncorConstant),
            bodyField.leadingAnchor.constraint(equalTo: mainAddReminderStackView.leadingAnchor,
                                               constant: Constants.Layout.textFieldsLeadingAncorConstant),
            
            datePicker.leadingAnchor.constraint(equalTo: mainAddReminderStackView.leadingAnchor),
            
            backButton.widthAnchor.constraint(equalToConstant: Constants.Layout.buttonsWidthAncorConstant),
            saveButton.widthAnchor.constraint(equalToConstant: Constants.Layout.buttonsWidthAncorConstant),
            buttonsStackView.heightAnchor.constraint(equalToConstant: Constants.Layout.buttonsStackViewHeightConstant),
        ])
    }
    
    @objc func backButtonTapped() {
        actionClosure?(nil)
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        guard let notificationTitle = titleField.text,
              let notificationBody = bodyField.text else { return }
        let notificationDate = datePicker.date
        
        let data = ReminderData(title: notificationTitle, body: notificationBody, date: notificationDate, identifier: nil)
        actionClosure?(data)
        dismiss(animated: true)
    }
}

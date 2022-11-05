//
//  ReminderCell.swift
//  ReminderApp
//
//  Created by Vladyslav Skrynnik on 15.06.2022.
//

import UIKit

class ReminderCell: UITableViewCell {
    enum Constants {
        static let helveticaFont = "Helvetica"
        
        enum Layout {
            static let reminderTitleFontSize = 17.0
            static let reminderBodyFontSize = 14.0
        }
    }
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.helveticaFont, size: Constants.Layout.reminderTitleFontSize)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.helveticaFont, size: Constants.Layout.reminderBodyFontSize)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        setUpAutolayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews() {
        backgroundColor = .secondarySystemBackground
        addSubview(cellStackView)
    }
    
    func setUpAutolayoutConstraints() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupCell(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }
}

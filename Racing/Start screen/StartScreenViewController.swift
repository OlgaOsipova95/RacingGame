//
//  StartScreenViewController.swift
//  Racing
//
//  Created by Olga on 28.11.2023.
//

import Foundation
import UIKit

class StartScreenViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.spacingStack
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSize22)
        button.setTitle("startScreen.start_button".localized(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(openGame), for: .touchUpInside)
        return button
    }()
    private var settingsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSize22)
        button.setTitle("startScreen.settings_button".localized(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(openSettings), for: .touchUpInside)
         return button
     }()
    private var recordsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSize22)
        button.setTitle("startScreen.records_button".localized(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(openRecords), for: .touchUpInside)
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(settingsButton)
        stackView.addArrangedSubview(recordsButton)
        view.addSubview(stackView)
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.offset64),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.offset64)
        ])
    }
    
    @objc func openSettings() {
        let settingsVC = SettingsViewController(presenter: SettingsPresenter())
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc func openGame() {
        let gameVC = GameViewController(presenter: GamePresenter())
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc func openRecords() {
        let recordsVC = RecordsTableViewController(presenter: RecordsPresenter())
        self.navigationController?.pushViewController(recordsVC, animated: true)
    }
}


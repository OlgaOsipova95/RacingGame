//
//  RecordsTableViewController.swift
//  Racing
//
//  Created by Olga on 16.12.2023.
//

import Foundation
import UIKit

class RecordsTableViewController: UIViewController {
    let presenter: RecordsPresenterProtocol
    init(presenter: RecordsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .leastNonzeroMagnitude
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupConstraints()
    }
    deinit {
        print("deinit \(self)")
    }
}

extension RecordsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.countCells()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, for: indexPath) as? RecordTableViewCell else { return RecordTableViewCell() }
        cell.configureUI(model: presenter.getDataCell(index: indexPath.row))
        return cell
    }
}

extension RecordsTableViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.offset16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.offset16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -(Constants.offset16)),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

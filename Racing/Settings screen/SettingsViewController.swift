//
//  SettingsViewController.swift
//  Racing
//
//  Created by Olga on 29.11.2023.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    private var presenter: SettingsProtocol
    private var imagePicker: ImagePicker? = nil
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: SettingCollectionViewCell.identifier)
        return collectionView
    }()
    init(presenter: SettingsProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        configureUI()
    }
    deinit {
        print("deinit \(self)")
    }

    private func configureUI() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
extension SettingsViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        presenter.setUserAvatar(image: image)
    }
}
extension SettingsViewController: ISettingsView {
    func showAlert(title: String, message: String?, values: [String], onClick: @escaping (Int) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, value) in values.enumerated() {
            alert.addAction(UIAlertAction(title: value, style: .default, handler: { _ in
                onClick(index)
            }))
        }
        alert.addAction(UIAlertAction(title: "action.cancel".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

@available(iOS 14.0, *)
extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.countOfCell()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.identifier, for: indexPath) as? UserCollectionViewCell else {
                return UserCollectionViewCell()
            }
            let model = UserCellModel(image: presenter.getUserAvatar(),
                                      name: presenter.getUserName()) { [weak self] in
                self?.imagePicker?.present()
            } didNameChanged: { [weak self] text in
                self?.presenter.setUserName(name: text)
            }
            cell.configureUI(model: model)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionViewCell.identifier, for: indexPath) as? SettingCollectionViewCell else {
                return SettingCollectionViewCell()
            }
            cell.configureUI(model: presenter.getDataCell(index: indexPath.row-1))
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            presenter.didSelectItem(index: indexPath.row - 1)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 0)
    }
}


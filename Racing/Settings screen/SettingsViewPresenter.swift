//
//  SettingsViewPresenter.swift
//  Racing
//
//  Created by Olga on 21.12.2023.
//

import Foundation
import UIKit

protocol SettingsProtocol: AnyObject {
    var delegate: ISettingsView? { get set }
    func countOfCell() -> Int
    func getDataCell(index: Int) -> SettingsDisplayItemModel
    func setUserAvatar(image: UIImage)
    func getUserAvatar() -> UIImage?
    func getUserName() -> String?
    func setUserName(name: String)
    func didSelectItem(index: Int)
}
protocol ISettingsView: AnyObject {
    func showAlert(title: String, message: String?, values: [String], onClick: @escaping (Int) -> Void)
    func reloadCollectionView()
}
protocol IDataUser: AnyObject {
    func showSelectPhoto()
}

class SettingsPresenter: SettingsProtocol {
    weak var delegate: ISettingsView?
    private let model = SettingsModel()
    
    func countOfCell() -> Int {
        model.getItemsCount() + 1
    }
    func getDataCell(index: Int) -> SettingsDisplayItemModel {
        model.getItem(index: index)
    }
    func setUserAvatar(image: UIImage) {
        guard let name = try? StorageManager().saveImage(image) else { return }
        model.userAvatarName = name
        delegate?.reloadCollectionView()
    }
    func getUserAvatar() -> UIImage? {
        guard let imageName = model.userAvatarName else { return nil }
        return StorageManager().loadImage(imageName)
    }
    func getUserName() -> String? {
        model.userName
    }
    func setUserName(name: String) {
        model.userName = name
    }
    func didSelectItem(index: Int) {
        let model = getDataCell(index: index)
        delegate?.showAlert(title: "", message: "", values: model.allValues, onClick: { [weak self] index in
            model.didChanged(index)
            self?.delegate?.reloadCollectionView()
        })
    }
    deinit {
        print("deinit \(self)")
    }
}

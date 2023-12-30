//
//  UserCollectionViewCell.swift
//  Racing
//
//  Created by Olga on 18.12.2023.
//

import Foundation
import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {"\(Self.self)"}
    static var widthImage: CGFloat = 200
    private var model: UserCellModel?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = widthImage/2
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let buttonImage: UIButton = {
        let buttonImage = UIButton(type: .system)
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        buttonImage.backgroundColor = .clear
        return buttonImage
    }()
    private let nameTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8.0
        textField.backgroundColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: Constants.fontSize18)
        textField.placeholder = "settingsScreen.placeholder_nameTextField".localized()
        return textField
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameTextField.delegate = self
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @available(iOS 14.0, *)
    func configureUI(model: UserCellModel) {
        self.model = model
        let action = UIAction { _ in
            model.onPickAvatar()
        }
        avatarImageView.image = model.image ?? UIImage(named: "placeholder_avatar")
        buttonImage.addAction(action, for: .touchUpInside)
        nameTextField.text = model.name
    }
}

extension UserCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        model?.didNameChanged(text)
        textField.resignFirstResponder()
        return false
    }
}

extension UserCollectionViewCell {
    func setupConstraints() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameTextField)
        contentView.addSubview(buttonImage)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.offset16),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: UserCollectionViewCell.widthImage),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            buttonImage.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            buttonImage.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            buttonImage.heightAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            buttonImage.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.offset16),
            nameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 32),
            nameTextField.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

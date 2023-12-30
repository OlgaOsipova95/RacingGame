//
//  SettingCollectionViewCell.swift
//  Racing
//
//  Created by Olga on 19.12.2023.
//

import Foundation
import UIKit

class SettingCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private let settingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize18)
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 8.0
        label.textAlignment = .center
        return label
    }()
    private let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize18)
        label.textAlignment = .right
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI(model: SettingsDisplayItemModel) {
        settingLabel.text = model.title
        valueLabel.text = model.value()
    }
}

extension SettingCollectionViewCell {
    func setupConstraints() {
        contentView.addSubview(settingLabel)
        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            settingLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            settingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.offset16),
            settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset16),
            settingLabel.heightAnchor.constraint(equalToConstant: 48),
            settingLabel.widthAnchor.constraint(equalTo: settingLabel.heightAnchor, multiplier: 3),
            
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.offset16),
            valueLabel.leadingAnchor.constraint(equalTo: settingLabel.trailingAnchor, constant: Constants.offset16),
            valueLabel.topAnchor.constraint(equalTo: settingLabel.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: settingLabel.bottomAnchor),
            valueLabel.heightAnchor.constraint(equalTo: settingLabel.heightAnchor)
        ])
    }
}

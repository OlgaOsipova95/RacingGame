//
//  RecordTableViewCell.swift
//  Racing
//
//  Created by Olga on 16.12.2023.
//

import Foundation
import UIKit


class RecordTableViewCell: UITableViewCell {
    static var identifier: String {"\(Self.self)"}
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize18)
        return label
    }()
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.fontSize18)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontSize18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
        scoreLabel.text = nil
    }
    func configureUI(model: RecordCellModel) {
        if let imageName = model.image {
            DispatchQueue.global().async {
                if let image = StorageManager().loadImage(imageName) {
                    DispatchQueue.main.async {
                        self.avatarImage.image = image
                    }
                }
            }
        } else {
            avatarImage.image = UIImage(named: "placeholder_avatar")
        }
        nameLabel.text = model.name
        dateLabel.text = model.date
        scoreLabel.text = model.score
    }
}

extension RecordTableViewCell {
    func setupConstraints() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            avatarImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.offset16),
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.offset16),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 40.0),
            
            nameLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: Constants.offset16),
            nameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            
            dateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.offset16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            scoreLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -(Constants.offset16))
        ])
    }
}

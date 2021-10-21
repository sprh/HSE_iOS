//
//  NoteCell.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

final class NoteCell: UICollectionViewCell {
    var id: ObjectIdentifier!

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Description"
        label.numberOfLines = 0
        return label
    }()

    lazy var statusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        return image
    }()

    func setup(with note: Note) {
        self.id = note.id
        titleLabel.text = note.title
        descriptionLabel.text = note.descriptionText
        if note.status == 1 {
            statusImage.image = .lowStatus
        } else if note.status == 2 {
            statusImage.image = .highStatus
        }
        backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(statusImage)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: statusImage.leadingAnchor, constant: -8),

            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: statusImage.leadingAnchor, constant: -8),            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            statusImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusImage.heightAnchor.constraint(equalToConstant: 15),
            statusImage.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
}

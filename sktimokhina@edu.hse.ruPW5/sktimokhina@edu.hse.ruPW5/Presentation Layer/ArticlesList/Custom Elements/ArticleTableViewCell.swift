//
//  ArticleTableViewCell.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 09.11.2021.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell {
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text"
        return label
    }()

    func setup() {
        selectionStyle = .none
        backgroundColor = .subviewBackground
        layer.cornerRadius = 16
        clipsToBounds = true

        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

        layoutSubviews()
    }
}

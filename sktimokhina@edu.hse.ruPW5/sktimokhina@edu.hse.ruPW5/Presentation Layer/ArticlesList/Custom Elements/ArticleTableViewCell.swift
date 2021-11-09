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
        label.font = UIFont.preferredFont(forTextStyle: .body).setBold()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text
        label.numberOfLines = 0
        return label
    }()

    lazy var desctiptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text
        label.numberOfLines = 3
        return label
    }()

    func setup(article: Article) {
        selectionStyle = .none
        backgroundColor = .subviewBackground
        layer.cornerRadius = 16
        clipsToBounds = true
        title.text = article.title
        desctiptionLabel.text = article.articleDescription

        contentView.addSubview(title)
        contentView.addSubview(desctiptionLabel)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            desctiptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            desctiptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            desctiptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            desctiptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

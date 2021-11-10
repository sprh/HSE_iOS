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

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        selectionStyle = .none
        backgroundColor = .subviewBackground
        layer.cornerRadius = 16
        clipsToBounds = true

        contentView.addSubview(title)
        contentView.addSubview(desctiptionLabel)
        contentView.addSubview(image)

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            desctiptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            desctiptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            desctiptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),

            image.topAnchor.constraint(equalTo: desctiptionLabel.bottomAnchor, constant: 16),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            image.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func setup(articleTitle: String,
               articleDescription: String,
               articleImage: UIImage) {
        title.text = articleTitle
        desctiptionLabel.text = articleDescription
        image.image = articleImage
    }

    func showShimmer() {
        image.backgroundColor = .loadingImageBackground
        image.startShimmeringAnimation()
    }

    func hideShimmer() {
        image.backgroundColor = .subviewBackground
        image.stopShimmeringAnimation()
    }
}

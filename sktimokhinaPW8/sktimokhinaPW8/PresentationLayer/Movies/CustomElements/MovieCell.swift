//
//  MovieCell.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import UIKit

class MovieCell: UITableViewCell {
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    func setup(movie: Movie) {
        title.text = movie.title
        contentView.addSubview(title)
        contentView.addSubview(poster)

        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            poster.heightAnchor.constraint(equalToConstant: 200),

            title.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        poster.image = movie.poster
    }

    func updateImage(_ image: UIImage) {
        poster.image = image
    }
}

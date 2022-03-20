//
//  Movie.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation
import UIKit

struct Movie: Codable {
    let title: String
    let posterPath: String
    let poster: UIImage?

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        poster = nil
    }

    init(title: String, posterPath: String, poster: UIImage?) {
        self.title = title
        self.posterPath = posterPath
        self.poster = poster
    }
}

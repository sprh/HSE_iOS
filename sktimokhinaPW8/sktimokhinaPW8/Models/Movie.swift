//
//  Movie.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation

struct Movie: Codable {
    let title: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }
}

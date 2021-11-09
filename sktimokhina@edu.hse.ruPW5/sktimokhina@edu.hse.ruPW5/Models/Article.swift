//
//  Article.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 09.11.2021.
//

struct Article: Codable {
    let title: String
    let articleDescription: String
    let url: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case title, url
        case articleDescription = "description"
        case imageUrl = "urlToImage"
    }
}

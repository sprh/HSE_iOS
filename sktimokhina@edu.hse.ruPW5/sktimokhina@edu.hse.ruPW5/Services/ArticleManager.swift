//
//  ArticleManager.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 09.11.2021.
//

import Foundation

protocol IArticleManager {
    var articles: [Article] { get set }
    var articlesCount: Int { get }

    func add(articles: [Article])
    func get(at index: Int) -> Article?
    func load()
}

final class ArticleManager: IArticleManager {
    private let networkService: INetworkService
    private var items: [Article]

    init(networkService: INetworkService) {
        self.networkService = networkService
        self.items = []
    }

    var articlesCount: Int {
        articles.count
    }

    var articles: [Article] {
        get {
            return items
        } set {
            items = newValue
        }
    }

    func add(articles: [Article]) {
        articles.forEach({ items.append($0) })
    }

    func get(at index: Int) -> Article? {
        if (articlesCount <= index) {
            return nil
        }
        return items[index]
    }

    func load() {
        networkService.load { [weak self] result in
            print(result)
        }
    }
}

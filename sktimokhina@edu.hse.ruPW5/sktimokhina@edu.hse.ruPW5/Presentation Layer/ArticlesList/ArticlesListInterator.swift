//
//  ArticlesListInterator.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import Foundation

protocol IArticlesListInteractor: AnyObject {
    var articlesCount: Int { get }

    func getArticle(at index: Int) -> Article?
    func load()
}

final class ArticlesListInterator: IArticlesListInteractor {
    private let presenter: IArticlesListPresenter
    private let articlesManager: IArticleManager

    var articlesCount: Int {
        articlesManager.articlesCount
    }

    init(presenter: IArticlesListPresenter,
         articlesManager: IArticleManager) {
        self.presenter = presenter
        self.articlesManager = articlesManager
    }

    func getArticle(at index: Int) -> Article? {
        return articlesManager.get(at: index)
    }

    func load() {
        articlesManager.load { [weak self] result in
            switch result {
            case .success():
                self?.presenter.updateArticlesList()
            case .failure(_):
                // TODO: show error
                break
            }
        }
    }
}

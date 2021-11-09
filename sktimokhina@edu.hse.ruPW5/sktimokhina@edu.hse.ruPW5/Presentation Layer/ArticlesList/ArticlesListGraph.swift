//
//  ArticlesListGraph.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import UIKit

final class ArticlesListGraph {
    private let view: IArticlesListVC
    private let interactor: IArticlesListInteractor
    private var presenter: IArticlesListPresenter
    private var router: IArticlesListRouter
    private let articlesManager: IArticleManager
    private let networkService: INetworkService

    var viewController: UIViewController {
        view
    }

    init() {
        presenter = ArticlesListPresenter()
        router = ArticlesListRouter()
        networkService = NetworkService()
        articlesManager = ArticleManager(networkService: networkService)
        interactor = ArticlesListInterator(presenter: presenter,
                                           articlesManager: articlesManager)
        view = ArticlesListVC(interator: interactor, router: router)
        router.viewController = view
        presenter.viewController = view

    }
}

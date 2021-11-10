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
    private let imageLoader: IImageLoader

    var viewController: UIViewController {
        view
    }

    init() {
        presenter = ArticlesListPresenter()
        router = ArticlesListRouter()
        networkService = NetworkService()
        imageLoader = ImageLoader()
        articlesManager = ArticleManager(networkService: networkService)
        interactor = ArticlesListInterator(presenter: presenter,
                                           articlesManager: articlesManager,
                                           imageLoader: imageLoader)
        view = ArticlesListVC(interator: interactor, router: router)
        router.viewController = view
        presenter.viewController = view

    }
}

//
//  ArticlesListRouter.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import UIKit

protocol IArticlesListRouter: AnyObject {
    var viewController: IArticlesListVC? { get set }

    func showError(message: String)
    func showArticleWebView(url: String)
}

final class ArticlesListRouter: IArticlesListRouter {
    func showArticleWebView(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let articleView = ArticleWebViewVC(url: url)
        viewController?.navigationController?.present(articleView, animated: true)
    }

    weak var viewController: IArticlesListVC?

    func showError(message: String) {
        let alert = UIAlertController(title: "Ops, something went wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.addAction(UIAlertAction(title: "Try to reload", style: .default) {[weak self] _ in
            self?.viewController?.loadArticles()
        })
        viewController?.present(alert, animated: true)
    }
}

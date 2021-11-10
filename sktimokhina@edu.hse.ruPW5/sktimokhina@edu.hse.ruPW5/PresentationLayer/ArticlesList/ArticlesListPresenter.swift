//
//  ArticlesListPresenter.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import Foundation

protocol IArticlesListPresenter: AnyObject {
    var viewController: IArticlesListVC? { get set }

    func updateArticlesList()
    func updateCell(at index: Int)
}

final class ArticlesListPresenter: IArticlesListPresenter {
    weak var viewController: IArticlesListVC?

    func updateArticlesList() {
        viewController?.updateArticlesList()
    }

    func updateCell(at index: Int) {
        viewController?.updateCell(at: index)
    }
}

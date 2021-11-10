//
//  ArticlesListInterator.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import Foundation
import UIKit

protocol IArticlesListInteractor: AnyObject {
    var articlesCount: Int { get }

    func getArticle(at index: Int) -> Article?
    func load()
    func getImage(for url: String, at index: Int) -> UIImage
    var hasNext: Bool { get }
}

final class ArticlesListInterator: IArticlesListInteractor {
    private let presenter: IArticlesListPresenter
    private let articlesManager: IArticleManager
    private let imageLoader: IImageLoader

    var hasNext: Bool {
        articlesManager.hasNext
    }

    var articlesCount: Int {
        articlesManager.articlesCount
    }

    init(presenter: IArticlesListPresenter,
         articlesManager: IArticleManager,
         imageLoader: IImageLoader) {
        self.presenter = presenter
        self.articlesManager = articlesManager
        self.imageLoader = imageLoader
    }

    func getArticle(at index: Int) -> Article? {
        return articlesManager.get(at: index)
    }

    func getImage(for url: String, at index: Int) -> UIImage {
        if let image = imageLoader.getImage(path: url) {
            return image
        }
        loadImage(for: url,
                  at: index)
        return UIImage()
    }

    func loadImage(for url: String, at index: Int) {
        imageLoader.loadImage(path: url) { [weak self] image in
            if image != nil {
                self?.presenter.updateCell(at: index)
            }
        }
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

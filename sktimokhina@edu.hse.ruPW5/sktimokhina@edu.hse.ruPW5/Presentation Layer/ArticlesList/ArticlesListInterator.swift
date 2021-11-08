//
//  ArticlesListInterator.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import Foundation

protocol IArticlesListInteractor: AnyObject {

}

final class ArticlesListInterator: IArticlesListInteractor {
    private let presenter: IArticlesListPresenter

    init(presenter: IArticlesListPresenter) {
        self.presenter = presenter
    }
}

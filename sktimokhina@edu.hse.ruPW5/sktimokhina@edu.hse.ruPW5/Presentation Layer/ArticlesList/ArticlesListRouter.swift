//
//  ArticlesListRouter.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import Foundation

protocol IArticlesListRouter: AnyObject {
    var viewController: IArticlesListVC? { get set }
}

final class ArticlesListRouter: IArticlesListRouter {
    weak var viewController: IArticlesListVC?
}

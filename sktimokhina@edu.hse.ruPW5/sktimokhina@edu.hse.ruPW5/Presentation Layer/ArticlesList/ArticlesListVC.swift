//
//  ArticlesListVC.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import UIKit

protocol IArticlesListVC: UIViewController {

}

final class ArticlesListVC: UIViewController, IArticlesListVC {
    private let interactor: IArticlesListInteractor
    private let router: IArticlesListRouter

    init(interator: IArticlesListInteractor, router: IArticlesListRouter) {
        self.interactor = interator
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

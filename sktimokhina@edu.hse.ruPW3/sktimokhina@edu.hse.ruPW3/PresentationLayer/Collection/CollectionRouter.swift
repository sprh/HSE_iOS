//
//  CollectionViewRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol ICollectionRouter {
}

final class ColletionViewRouter: ICollectionRouter {
    weak var viewController: ICollectionVC?

    init(viewController: ICollectionVC) {
        self.viewController = viewController
    }
}

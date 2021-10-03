//
//  TableViewRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol ITableRouter {
}

final class TableViewRouter: ITableRouter {
    weak var viewController: ITableVC?

    init(viewController: ITableVC) {
        self.viewController = viewController
    }
}

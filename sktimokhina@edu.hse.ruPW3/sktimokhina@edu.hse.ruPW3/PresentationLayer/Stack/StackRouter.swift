//
//  StackViewRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol IStackRouter {
}

final class StackViewRouter: IStackRouter {
    weak var viewController: IStackVC?

    init(viewController: IStackVC) {
        self.viewController = viewController
    }
}

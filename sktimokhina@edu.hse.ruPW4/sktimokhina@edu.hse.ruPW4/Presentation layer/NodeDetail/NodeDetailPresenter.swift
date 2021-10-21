//
//  CreateNodePresenter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

protocol ICreateNodePresenter {
    var viewController: ICreateNodeVC? { get set }

    func shouldShowError(message: String)
    func shouldClose()
}

final class CreateNodePresenter: ICreateNodePresenter {
    weak var viewController: ICreateNodeVC?

    func shouldClose() {
        viewController?.shouldClose()
    }

    func shouldShowError(message: String) {
        viewController?.shouldShowError(message: message)
    }
}

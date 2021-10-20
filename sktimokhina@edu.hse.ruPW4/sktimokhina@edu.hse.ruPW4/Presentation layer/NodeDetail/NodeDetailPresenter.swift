//
//  NodeDetailPresenter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

protocol INodeDetailPresenter {
    var viewController: INodeDetailVC? { get set }

    func shouldShowError(message: String)
    func shouldClose()
}

final class NodeDetailPresenter: INodeDetailPresenter {
    weak var viewController: INodeDetailVC?

    func shouldClose() {
        viewController?.shouldClose()
    }

    func shouldShowError(message: String) {
        viewController?.shouldShowError(message: message)
    }
}

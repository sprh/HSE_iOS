//
//  NodesListPresenter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

protocol INodesListPresenter {
    var viewController: INodesListVC? { get set }

    func shouldReloadItems()
    func shouldShowError(text: String)
}

final class NodesListPresenter: INodesListPresenter {
    weak var viewController: INodesListVC?

    func shouldReloadItems() {
        viewController?.shouldReloadItems()
    }

    func shouldShowError(text: String) {
        viewController?.shouldShowError(text: text)
    }
}

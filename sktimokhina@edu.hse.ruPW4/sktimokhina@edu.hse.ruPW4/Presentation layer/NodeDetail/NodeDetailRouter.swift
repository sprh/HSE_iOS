//
//  NodeDetailRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodeDetailRouter {
    var viewController: INodeDetailVC? { get set }

    func showError(message: String)
}

final class NodeDetailViewRouter: INodeDetailRouter {
    weak var viewController: INodeDetailVC?

    func showError(message: String) {
        let alert = UIAlertController(title: "Ops, can't save", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController?.present(alert, animated: true)
    }
}

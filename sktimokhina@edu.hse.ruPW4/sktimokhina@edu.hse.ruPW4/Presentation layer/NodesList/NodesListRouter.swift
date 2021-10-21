//
//  NodesListRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodesListRouter {
    var viewController: INodesListVC? { get set }

    func shouldShowDetailScreen(worker: ICoreDataWorker, observer: ICreateNodeViewObserver?)
    func showError(text: String)
}

final class NodesListViewRouter: INodesListRouter {
    weak var viewController: INodesListVC?

    func shouldShowDetailScreen(worker: ICoreDataWorker, observer: ICreateNodeViewObserver?) {
        let viewController = CreateNodeGraph(worker: worker, observer: observer).viewController
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func showError(text: String) {
        let alert = UIAlertController(title: "Error(", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController?.present(alert, animated: true)
    }
}

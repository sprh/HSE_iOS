//
//  NodesListRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodesListRouter {
    var viewController: INodesListVC? { get set }

    func shouldShowDetailScreen()
}

final class NodesListViewRouter: INodesListRouter {
    weak var viewController: INodesListVC?

    func shouldShowDetailScreen() {
        let viewController = NodeDetailGraph().viewController
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}

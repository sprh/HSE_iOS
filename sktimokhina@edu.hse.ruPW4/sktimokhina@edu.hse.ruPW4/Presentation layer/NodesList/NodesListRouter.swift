//
//  NodesListRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodesListRouter {
    var viewController: INodesListVC? { get set }
}

final class NodesListViewRouter: INodesListRouter {
    weak var viewController: INodesListVC?
}

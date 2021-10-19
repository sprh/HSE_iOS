//
//  NodeDetailRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodeDetailRouter {
    var viewController: INodeDetailVC? { get set }
}

final class NodeDetailViewRouter: INodeDetailRouter {
    weak var viewController: INodeDetailVC?
}

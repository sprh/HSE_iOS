//
//  NodeDetailPresenter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

protocol INodeDetailPresenter {
    var viewController: INodeDetailVC? { get set }
}

final class NodeDetailPresenter: INodeDetailPresenter {
    weak var viewController: INodeDetailVC?
}

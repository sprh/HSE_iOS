//
//  NodeDetailInteractor.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

import Foundation

protocol INodeDetailInteractor {
}

final class NodeDetailInteractor: INodeDetailInteractor {
    let presenter: INodeDetailPresenter

    init(presenter: INodeDetailPresenter) {
        self.presenter = presenter
    }
}

//
//  NodesListInteractor.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

import Foundation

protocol INodesListInteractor {
}

final class NodesListInteractor: INodesListInteractor {
    let presenter: INodesListPresenter

    init(presenter: INodesListPresenter) {
        self.presenter = presenter
    }
}

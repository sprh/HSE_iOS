//
//  NodeDetailInteractor.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

import Foundation

protocol INodeDetailViewObserver: AnyObject {
    func didAddItem()
}

protocol INodeDetailInteractor {
    func saveNode(title: String, description: String, importance: Int32)
}

final class NodeDetailInteractor: INodeDetailInteractor {
    let presenter: INodeDetailPresenter
    let worker: ICoreDataWorker
    weak var observer: INodeDetailViewObserver?

    init(presenter: INodeDetailPresenter, worker: ICoreDataWorker, observer: INodeDetailViewObserver?) {
        self.presenter = presenter
        self.observer = observer
        self.worker = worker
    }

    func saveNode(title: String, description: String, importance: Int32) {
        do {
            try worker.save(title: title, description: description, importance: importance)
            observer?.didAddItem()
            presenter.shouldClose()
        } catch (let e) {
            presenter.shouldShowError(message: e.localizedDescription)
        }
    }
}

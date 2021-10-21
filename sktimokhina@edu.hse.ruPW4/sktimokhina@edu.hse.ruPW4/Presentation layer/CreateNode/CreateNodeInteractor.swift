//
//  CreateNodeInteractor.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

import Foundation

protocol ICreateNodeViewObserver: AnyObject {
    func didAddItem()
}

protocol ICreateNodeInteractor {
    func saveNode(title: String, description: String, importance: Int32)
}

final class CreateNodeInteractor: ICreateNodeInteractor {
    let presenter: ICreateNodePresenter
    let worker: ICoreDataWorker
    weak var observer: ICreateNodeViewObserver?

    init(presenter: ICreateNodePresenter, worker: ICoreDataWorker, observer: ICreateNodeViewObserver?) {
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

//
//  NodesListInteractor.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

import Foundation

protocol INodesListInteractor {
    var nodesCount: Int { get }
    var coreDataWorker: ICoreDataWorker { get }
    func load()

    func getNodeAt(index: Int) -> Node?
}

final class NodesListInteractor: INodesListInteractor {
    let presenter: INodesListPresenter
    private let worker: ICoreDataWorker

    private var nodes: [Node] = []

    var coreDataWorker: ICoreDataWorker {
        worker
    }

    var nodesCount: Int {
        nodes.count
    }

    func getNodeAt(index: Int) -> Node? {
        return index < nodes.count ? nodes[index] : nil
    }

    init(presenter: INodesListPresenter, worker: ICoreDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func load() {
        do {
            nodes = try worker.loadAll()
            presenter.shouldReloadItems()
        } catch (let e) {
            presenter.shouldShowError(text: e.localizedDescription)
        }
    }

    func deleteNode(id: ObjectIdentifier) {
        guard let node = nodes.first(where: { $0.id == id }) else { return }
        do {
            try worker.delete(node: node)
            presenter.shouldReloadItems()
        } catch (let e) {
            presenter.shouldShowError(text: e.localizedDescription)
        }
    }
}

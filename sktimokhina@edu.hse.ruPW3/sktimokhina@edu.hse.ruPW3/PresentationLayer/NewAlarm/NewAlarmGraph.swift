//
//  NewAlarmGraph.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit
import CoreData

final class NewAlarmGraph {
    private let view: INewAlarmVC
    private let interactor: INewAlarmInteractor
    private var presenter: INewAlarmPresenter
    private var router: INewAlarmRouter
    private let worker: ICoreDataWorker

    var viewController: UIViewController {
        view
    }

    init(worker: ICoreDataWorker, alarm: Alarm? = nil, observer: IAlarmUpdaterObserver? = nil) {
        presenter = NewAlarmPresenter()
        self.worker = worker
        interactor = NewAlarmInteractor(presenter: presenter, worker: worker, alarm: alarm, observer: observer)
        router = NewAlarmViewRouter()
        view = NewAlarmVC(interactor: interactor, router: router)
        presenter.viewController = view
        router.viewController = view
    }
}

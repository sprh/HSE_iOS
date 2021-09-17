//
//  MainScreenGraph.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

final class MainScreenGraph {
    private var presenter: IMainScreenPresenter
    private var interactor: IMainScreenInteractor
    private var view: IMainScreenVC
    private var router: IMainScreenRouter

    var viewController: UIViewController {
        view
    }

    init() {
        router = MainScreenRouter()
        view = MainScreenVC(router: router)
        presenter = MainScreenPresenter(viewController: view)
        interactor = MainScreenInteractor(presenter: presenter)
        view.interactor = interactor
    }
}

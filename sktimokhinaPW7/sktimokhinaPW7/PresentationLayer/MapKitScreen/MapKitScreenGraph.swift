//
//  MapKitScreenGraph.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import UIKit

final class MapKitScreenGraph {
    private let view: IMapKitScreenVC
    private let interactor: IMapKitScreenInteractor
    private var presenter: IMapKitScreenPresenter

    var viewController: UIViewController {
        view
    }

    init() {
        presenter = MapKitScreenPresenter()
        interactor = MapKitScreenInteractor(presenter: presenter)
        view = MapKitScreenVC(interator: interactor)
        presenter.viewController = view
    }
}

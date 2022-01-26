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
    private let entity: MapKitScreenEntity

    var viewController: UIViewController {
        view
    }

    init() {
        entity = MapKitScreenEntity()
        presenter = MapKitScreenPresenter()
        interactor = MapKitScreenInteractor(presenter: presenter, entity: entity)
        view = MapKitScreenVC(interator: interactor)
        presenter.viewController = view
    }
}

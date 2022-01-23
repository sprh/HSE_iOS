//
//  MapKitScreenPresenter.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import Foundation

protocol IMapKitScreenPresenter {
    var viewController: IMapKitScreenVC? { get set }

    func onGetRouteError(error: String)
    func onGetRoute(route: Route)
}

final class MapKitScreenPresenter: IMapKitScreenPresenter {
    weak var viewController: IMapKitScreenVC?

    func onGetRouteError(error: String) {
        viewController?.onGetRouteError(error: error)
    }

    func onGetRoute(route: Route) {
        viewController?.onGetRoute(route: route)
    }
}

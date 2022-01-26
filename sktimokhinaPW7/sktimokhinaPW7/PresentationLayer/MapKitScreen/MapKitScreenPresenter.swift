//
//  MapKitScreenPresenter.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import YandexMapsMobile

protocol IMapKitScreenPresenter {
    var viewController: IMapKitScreenVC? { get set }

    func onGetRouteError(error: String)
    func onGetRoute(routePoints: Route, route: YMKDrivingRoute)
    func onGetRoute(routePoints: Route, route: YMKBicycleRoute)
    func onGetRoute(routePoints: Route, route: YMKMasstransitRoute)
}

final class MapKitScreenPresenter: IMapKitScreenPresenter {
    func onGetRoute(routePoints: Route, route: YMKDrivingRoute) {
        viewController?.onGetRoute(routePoints: routePoints, route: route)
    }

    func onGetRoute(routePoints: Route, route: YMKBicycleRoute) {
        viewController?.onGetRoute(routePoints: routePoints, route: route)
    }

    func onGetRoute(routePoints: Route, route: YMKMasstransitRoute) {
        viewController?.onGetRoute(routePoints: routePoints, route: route)
    }

    weak var viewController: IMapKitScreenVC?

    func onGetRouteError(error: String) {
        viewController?.onGetRouteError(error: error)
    }
}

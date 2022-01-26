//
//  MapKitScreenInteractor.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import YandexMapsMobile


protocol IMapKitScreenInteractor {
    func getRoute(from: String, to: String, of type: RouteType, region: YMKVisibleRegion)

    var hasRoute: Bool { get }
    func clearRoutes()
    func updateRoute(of type: RouteType)
}

final class MapKitScreenInteractor: IMapKitScreenInteractor {
    private let presenter: IMapKitScreenPresenter
    private let entity: MapKitScreenEntity
    private let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)

    var hasRoute: Bool {
        entity.route != nil
    }

    init(presenter: IMapKitScreenPresenter, entity: MapKitScreenEntity) {
        self.presenter = presenter
        self.entity = entity
    }

    func getRoute(from: String, to: String,
                  of type: RouteType,
                  region: YMKVisibleRegion) {
        clearRoutes()

        var start: YMKPoint?
        var end: YMKPoint?
        let group = DispatchGroup()
        // from https://github.com/yandex/mapkit-ios-demo/blob/master/MapKitDemo/SearchViewController.swift
        group.enter()
        var responseHandler = {[weak self] (searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            if let response = searchResponse {
                start = response.point
            } else {
                self?.presenter.onGetRouteError(error: error?.localizedDescription ?? "Ops, can't find point")
            }
            group.leave()
        }
        entity.fromSearchSession = searchManager.submit(
            withText: from,
            geometry: YMKVisibleRegionUtils.toPolygon(with: region),
            searchOptions: YMKSearchOptions(),
            responseHandler: responseHandler)

        group.enter()
        responseHandler = {[weak self] (searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            if let response = searchResponse {
                end = response.point
            } else {
                self?.presenter.onGetRouteError(error: error?.localizedDescription ?? "Ops, can't find point")
            }
            group.leave()
        }
        entity.toSearchSession = searchManager.submit(
            withText: to,
            geometry: YMKVisibleRegionUtils.toPolygon(with: region),
            searchOptions: YMKSearchOptions(),
            responseHandler: responseHandler)

        group.notify(queue: .main) {
            DispatchQueue.main.async { [weak self] in
                if let start = start,
                   let end = end {
                    self?.entity.route = Route(from: start, to: end)
                    self?.getSession(of: type)
                }
            }
        }
    }

    private func getSession(of type: RouteType) {
        guard let route = entity.route else {
            return
        }
        let requestPoints : [YMKRequestPoint] = [
            YMKRequestPoint(point: route.from, type: .waypoint, pointContext: nil),
            YMKRequestPoint(point: route.to, type: .waypoint, pointContext: nil),
        ]
        switch type {
        case .car:
            let responseHandler = {[weak self] (routesResponse: [YMKDrivingRoute]?, error: Error?) -> Void in
                if let routes = routesResponse,
                   let firstRoute = routes.first {
                    self?.presenter.onGetRoute(routePoints: route, route: firstRoute)
                } else {
                    self?.presenter.onGetRouteError(error: error?.localizedDescription ?? "Ops, can't find routes")
                }
            }
            let router = YMKDirections.sharedInstance().createDrivingRouter()
            entity.drivingSession = router.requestRoutes(
                with: requestPoints,
                drivingOptions: YMKDrivingDrivingOptions(),
                vehicleOptions: YMKDrivingVehicleOptions(),
                routeHandler: responseHandler
            )
        case .bycycle:
            let responseHandler = {[weak self] (routesResponse: [YMKBicycleRoute]?, error: Error?) -> Void in
                if let routes = routesResponse,
                   let firstRoute = routes.first {
                    self?.presenter.onGetRoute(routePoints: route, route: firstRoute)
                } else {
                    self?.presenter.onGetRouteError(error: error?.localizedDescription ?? "Ops, can't find routes")
                }
            }
            let router = YMKTransport.sharedInstance().createBicycleRouter()
            entity.bicycleSession = router.requestRoutes(
                with: requestPoints,
                routeListener: responseHandler
            )
        case .masstransit:
            let responseHandler = {[weak self] (routesResponse: [YMKMasstransitRoute]?, error: Error?) -> Void in
                if let routes = routesResponse,
                   let firstRoute = routes.first {
                    self?.presenter.onGetRoute(routePoints: route, route: firstRoute)
                } else {
                    self?.presenter.onGetRouteError(error: error?.localizedDescription ?? "Ops, can't find routes")
                }
            }
            let router = YMKTransport.sharedInstance().createPedestrianRouter()
            entity.masstransitSession =  router.requestRoutes(
                with: requestPoints,
                timeOptions: YMKTimeOptions(),
                routeHandler: responseHandler
            )
        }
    }

    func clearRoutes() {
        entity.clear()
    }

    func updateRoute(of type: RouteType) {
        getSession(of: type)
    }
}

private extension YMKSearchResponse {
    var point: YMKPoint? {
        collection.children.first?.obj?.geometry.first?.point
    }
}

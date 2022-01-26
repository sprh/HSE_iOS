//
//  MapKitScreenInteractor.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import CoreLocation
import YandexMapsMobile


protocol IMapKitScreenInteractor {
    func getRoute(from: String, to: String, of type: RouteType)
}

final class MapKitScreenInteractor: IMapKitScreenInteractor {
    private let presenter: IMapKitScreenPresenter
    private let queue = DispatchQueue(label: "MapKitScreenInteractor")
    private let entity: MapKitScreenEntity

    init(presenter: IMapKitScreenPresenter, entity: MapKitScreenEntity) {
        self.presenter = presenter
        self.entity = entity
    }

    func getRoute(from: String, to: String, of type: RouteType) {
        var start: YMKPoint?
        var end: YMKPoint?
        let group = DispatchGroup()
        group.enter()
        getCoordinateFrom(address: from, completion: { [weak self] coords, error in
            if let error = error {
                self?.presenter.onGetRouteError(error: error.localizedDescription)
                group.leave()
                return
            } else if let coords = coords {
                start = YMKPoint(latitude: coords.latitude, longitude: coords.longitude)
            }
            group.leave()
        })
        group.enter()
        getCoordinateFrom(address: to, completion: { [weak
                                                      self] coords, error in
            if let error = error {
                self?.presenter.onGetRouteError(error: error.localizedDescription)
                group.leave()
                return
            } else if let coords = coords {
                end = YMKPoint(latitude: coords.latitude, longitude: coords.longitude)
            }
            group.leave()
        })
        group.notify(queue: .main) {
            DispatchQueue.main.async { [weak self] in
                if let start = start,
                   let end = end {
                    let route = Route(from: start, to: end)
                    self?.getSession(for: route, of: type)
                }
            }
        }
    }

    private func getSession(for route: Route,
                            of type: RouteType) {
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

    private func getCoordinateFrom(address: String,
                                   completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        DispatchQueue.global(qos: .background).async {
            CLGeocoder().geocodeAddressString(address)
            { completion($0?.first?.location?.coordinate, $1) }
        }
    }
}

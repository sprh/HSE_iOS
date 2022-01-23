//
//  MapKitScreenInteractor.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import CoreLocation
import YandexMapsMobile


protocol IMapKitScreenInteractor {
    func getRoute(from: String, to: String)
}

final class MapKitScreenInteractor: IMapKitScreenInteractor {
    private let presenter: IMapKitScreenPresenter
    private let queue = DispatchQueue(label: "MapKitScreenInteractor")

    init(presenter: IMapKitScreenPresenter) {
        self.presenter = presenter
    }

    func getRoute(from: String, to: String) {
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
                    self?.presenter.onGetRoute(route: Route(from: start, to: end))
                }
            }
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

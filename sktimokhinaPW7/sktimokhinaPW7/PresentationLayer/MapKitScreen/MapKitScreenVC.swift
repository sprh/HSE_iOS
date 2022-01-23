//
//  MapKitScreenVC.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import UIKit
import YandexMapsMobile

protocol IMapKitScreenVC: UIViewController {

}

final class MapKitScreenVC: UIViewController, IMapKitScreenVC {
    private let interactor: IMapKitScreenInteractor

    lazy var mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.frame = view.frame
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        return mapView
    }()

    init(interator: IMapKitScreenInteractor) {
        self.interactor = interator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
    }
}

//extension MapKitScreenVC: YMKLocationDelegate {
//    func onLocationUpdated(with location: YMKLocation) {
//        print(location)
//        let lat = location.position.latitude
//        let lon = location.position.longitude
//        mapView.mapWindow.map.move(
//            with: YMKCameraPosition.init(target: YMKPoint(latitude: lat, longitude: lon),
//                                         zoom: 5,
//                                         azimuth: 0,
//                                         tilt: 0),
//            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
//            cameraCallback: nil)
//    }
//
//    func onLocationStatusUpdated(with status: YMKLocationStatus) {
//        print(status)
//    }
//}

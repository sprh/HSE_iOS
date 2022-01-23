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

    lazy var fromTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.placeholder = "From"
        textField.becomeFirstResponder()
        textField.borderStyle = .roundedRect
        return textField
    }()

    lazy var toTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.placeholder = "To"
        textField.borderStyle = .roundedRect
        return textField
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
        view.hideKeyboardWhenTappedAround()
        setup()
    }

    func setup() {
        view.addSubview(mapView)
        view.addSubview(fromTextField)
        view.addSubview(toTextField)

        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fromTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fromTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fromTextField.heightAnchor.constraint(equalToConstant: 30),

            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 16),
            toTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toTextField.heightAnchor.constraint(equalToConstant: 30),
        ])
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

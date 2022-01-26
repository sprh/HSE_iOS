//
//  MapKitScreenVC.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import UIKit
import YandexMapsMobile

protocol IMapKitScreenVC: UIViewController {
    func onGetRouteError(error: String)
    func onGetRoute(routePoints: Route, route: YMKDrivingRoute)
    func onGetRoute(routePoints: Route, route: YMKBicycleRoute)
    func onGetRoute(routePoints: Route, route: YMKMasstransitRoute)
}

final class MapKitScreenVC: UIViewController, IMapKitScreenVC {
    private let interactor: IMapKitScreenInteractor
    private var drivingSession: YMKDrivingSession?
    private var hasMapObjects = false


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
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()

    lazy var toTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.placeholder = "To"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()

    private var clearButton: UIButton = {
        let buttonViewModel = MainButton.ViewModel(font: .preferredFont(forTextStyle: .body),
                                                   title: "Clear",
                                                   enabledBackgroundColor: .systemYellow,
                                                   disabledBackgroundColor: .gray,
                                                   enabledTextColor: .black,
                                                   disabledTextColor: .black)
        let button = MainButton(viewModel: buttonViewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isEnabled = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(onTapClear), for: .touchUpInside)
        return button
    }()

    private var goButton: UIButton = {
        let buttonViewModel = MainButton.ViewModel(font: .preferredFont(forTextStyle: .body),
                                                   title: "Go",
                                                   enabledBackgroundColor: .systemOrange,
                                                   disabledBackgroundColor: .gray,
                                                   enabledTextColor: .black,
                                                   disabledTextColor: .black)
        let button = MainButton(viewModel: buttonViewModel)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isEnabled = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(onTapGo), for: .touchUpInside)
        return button
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
        view.addSubview(clearButton)
        view.addSubview(goButton)

        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fromTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fromTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fromTextField.heightAnchor.constraint(equalToConstant: 30),

            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 16),
            toTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toTextField.heightAnchor.constraint(equalToConstant: 30),

            goButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            goButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            goButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -16),
            goButton.heightAnchor.constraint(equalToConstant: 30),

            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            clearButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 16),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clearButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    @objc
    func onTapClear() {
        clear()
    }

    @objc
    func onTapGo() {
        getRoute()
    }

    func getRoute() {
        guard let from = fromTextField.text,
              let to = toTextField.text,
              from != to else {
                  showError(errorMessage: "One of routes is nil or routes are the same")
                  return
              }
        interactor.getRoute(from: from, to: to, of: .car)
    }

    func clear() {
        mapView.mapWindow.map.mapObjects.clear()
        fromTextField.text = ""
        toTextField.text = ""
        hasMapObjects = false
    }

    func onGetRouteError(error: String) {
        showError(errorMessage: error)
    }

    func addPlacemark(for points: [YMKPoint], images: [UIImage?]) {
        let collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)
        for i in 0..<min(points.count, images.count) {
            collection.addPlacemark(with: points[i],
                                    image: images[i] ?? UIImage(),
                                    style: YMKIconStyle.init())
        }
        collection.clusterPlacemarks(withClusterRadius: 60, minZoom: 50)
    }

    func onGetRoute(routePoints: Route, route: YMKDrivingRoute) {
        clear()
        let boundingBox = YMKBoundingBox(southWest: routePoints.from, northEast: routePoints.to)
        let cameraPos = mapView.mapWindow.map.cameraPosition(with: boundingBox)
        mapView.mapWindow.map.move(with: YMKCameraPosition(target: cameraPos.target,
                                                           zoom: cameraPos.zoom,
                                                           azimuth: cameraPos.azimuth,
                                                           tilt: cameraPos.tilt))
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.addPolyline(with: route.geometry)
        addPlacemark(for: [routePoints.from, routePoints.to],
                        images: [UIImage(systemName: "a.circle.fill"),
                                 UIImage(systemName: "b.circle.fill")])
    }

    func onGetRoute(routePoints: Route, route: YMKBicycleRoute) {
        clear()
        let boundingBox = YMKBoundingBox(southWest: routePoints.from, northEast: routePoints.to)
        let cameraPos = mapView.mapWindow.map.cameraPosition(with: boundingBox)
        mapView.mapWindow.map.move(with: YMKCameraPosition(target: cameraPos.target,
                                                           zoom: cameraPos.zoom,
                                                           azimuth: cameraPos.azimuth,
                                                           tilt: cameraPos.tilt))
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.addPolyline(with: route.geometry)
        addPlacemark(for: [routePoints.from, routePoints.to],
                        images: [UIImage(systemName: "a.circle.fill"),
                                 UIImage(systemName: "b.circle.fill")])
    }

    func onGetRoute(routePoints: Route, route: YMKMasstransitRoute) {
        clear()
        let boundingBox = YMKBoundingBox(southWest: routePoints.from, northEast: routePoints.to)
        let cameraPos = mapView.mapWindow.map.cameraPosition(with: boundingBox)
        mapView.mapWindow.map.move(with: YMKCameraPosition(target: cameraPos.target,
                                                           zoom: cameraPos.zoom,
                                                           azimuth: cameraPos.azimuth,
                                                           tilt: cameraPos.tilt))
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.addPolyline(with: route.geometry)
        addPlacemark(for: [routePoints.from, routePoints.to],
                        images: [UIImage(systemName: "a.circle.fill"),
                                 UIImage(systemName: "b.circle.fill")])
    }

    func showError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}

extension MapKitScreenVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (toTextField.text?.isEmpty ?? true || fromTextField.text?.isEmpty ?? true) {
            return false;
        }
        textField.resignFirstResponder()
        getRoute()
        return true
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        goButton.isEnabled = !(fromTextField.text?.isEmpty ?? true) && !(toTextField.text?.isEmpty ?? true)
        clearButton.isEnabled = !(fromTextField.text?.isEmpty ?? true) || !(toTextField.text?.isEmpty ?? true) || hasMapObjects
    }
}

extension MapKitScreenVC: YMKClusterListener {
    func onClusterAdded(with cluster: YMKCluster) {
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

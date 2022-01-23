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
    func onGetRoute(route: Route)
}

final class MapKitScreenVC: UIViewController, IMapKitScreenVC {
    private let interactor: IMapKitScreenInteractor
    var drivingSession: YMKDrivingSession?


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
        return textField
    }()

    lazy var toTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.placeholder = "To"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        mapView.mapWindow.map.mapObjects.clear()
        fromTextField.text = ""
        toTextField.text = ""
    }

    @objc
    func onTapGo() {
        guard let from = fromTextField.text,
              let to = toTextField.text,
              from != to else {
                  showError(errorMessage: "One of routes is nil or routes are the same")
                  return
              }
        interactor.getRoute(from: from, to: to)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        goButton.isEnabled = !(fromTextField.text?.isEmpty ?? true) && !(toTextField.text?.isEmpty ?? true)
        // TODO: update
        clearButton.isEnabled = !(fromTextField.text?.isEmpty ?? true) || !(toTextField.text?.isEmpty ?? true)
    }

    func onGetRouteError(error: String) {
        showError(errorMessage: error)
    }

    func onGetRoute(route: Route) {
        let requestPoints : [YMKRequestPoint] = [
            YMKRequestPoint(point: route.from, type: .waypoint, pointContext: nil),
            YMKRequestPoint(point: route.to, type: .waypoint, pointContext: nil),
            ]

        let responseHandler = {(routesResponse: [YMKDrivingRoute]?, error: Error?) -> Void in
            if let routes = routesResponse {
                self.onRoutesReceived(routes)
            } else {
                self.onRoutesError(error!)
            }
        }

        let drivingRouter = YMKDirections.sharedInstance().createDrivingRouter()
        drivingSession = drivingRouter.requestRoutes(
            with: requestPoints,
            drivingOptions: YMKDrivingDrivingOptions(),
            vehicleOptions: YMKDrivingVehicleOptions(),
            routeHandler: responseHandler)
    }

    func onRoutesReceived(_ routes: [YMKDrivingRoute]) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        guard let firstRoute = routes.first else {
            showError(errorMessage: "Ops, can't find routes")
            return
        }
        mapObjects.addPolyline(with: firstRoute.geometry)
    }

    func onRoutesError(_ error: Error) {
        let routingError = (error as NSError).userInfo[YRTUnderlyingErrorKey] as! YRTError
        var errorMessage = "Unknown error"
        if routingError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Network error"
        } else if routingError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Remote server error"
        }
        showError(errorMessage: errorMessage)
    }

    func showError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
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

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

final class MapKitScreenVC: UIViewController {
    private let interactor: IMapKitScreenInteractor
    private var drivingSession: YMKDrivingSession?
    private var hasMapObjects = false

    private var currentRouteType: RouteType {
        RouteType(rawValue: viewModel.routeTypeSegmentedControl.selectedSegmentIndex) ?? .car
    }

    lazy var viewModel: MapKitScreenViewModel = {
        let viewModel = MapKitScreenViewModel(frame: view.frame)
        viewModel.fromTextField.addTarget(self,
                                          action: #selector(textFieldDidChange(_:)),
                                          for: .editingChanged)
        viewModel.fromTextField.delegate = self
        viewModel.toTextField.addTarget(self,
                                          action: #selector(textFieldDidChange(_:)),
                                          for: .editingChanged)
        viewModel.toTextField.delegate = self
        viewModel.clearButton.addTarget(self, action: #selector(onTapClear), for: .touchUpInside)
        viewModel.goButton.addTarget(self, action: #selector(onTapGo), for: .touchUpInside)
        viewModel.routeTypeSegmentedControl.addTarget(self, action: #selector(onRouteTypeChanged), for: .valueChanged)
        return viewModel
    }()

    lazy var mapView = viewModel.mapView

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
        view.addSubview(viewModel)
    }

    @objc
    func onTapClear() {
        interactor.clearRoutes()
        clear()
    }

    @objc
    func onTapGo() {
        getRoute()
    }

    @objc
    private func onRouteTypeChanged() {
        if (interactor.hasRoute) {
            interactor.updateRoute(of: currentRouteType)
        }
    }

    private func getRoute() {
        guard let from = viewModel.fromTextField.text,
              let to = viewModel.toTextField.text,
              from != to else {
                  showError(errorMessage: "One of routes is nil or routes are the same")
                  return
              }
        interactor.getRoute(from: from, to: to, of: currentRouteType)
    }

    private func clear() {
        viewModel.mapView.mapWindow.map.mapObjects.clear()
        viewModel.fromTextField.text = ""
        viewModel.toTextField.text = ""
        hasMapObjects = false
    }

    private func showError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}

extension MapKitScreenVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (viewModel.toTextField.text?.isEmpty ?? true || viewModel.fromTextField.text?.isEmpty ?? true) {
            return false;
        }
        textField.resignFirstResponder()
        getRoute()
        return true
    }

    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        viewModel.goButton.isEnabled = !(viewModel.fromTextField.text?.isEmpty ?? true) && !(viewModel.toTextField.text?.isEmpty ?? true)
        viewModel.clearButton.isEnabled = !(viewModel.fromTextField.text?.isEmpty ?? true) || !(viewModel.toTextField.text?.isEmpty ?? true) || hasMapObjects
    }
}

extension MapKitScreenVC: YMKClusterListener {
    func onClusterAdded(with cluster: YMKCluster) {
    }

    private func addPlacemark(for points: [YMKPoint], images: [UIImage?]) {
        let collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)
        for i in 0..<min(points.count, images.count) {
            collection.addPlacemark(with: points[i],
                                    image: images[i] ?? UIImage(),
                                    style: YMKIconStyle.init())
        }
        collection.clusterPlacemarks(withClusterRadius: 60, minZoom: 50)
    }
}

extension MapKitScreenVC: IMapKitScreenVC {
    func onGetRouteError(error: String) {
        showError(errorMessage: error)
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
}

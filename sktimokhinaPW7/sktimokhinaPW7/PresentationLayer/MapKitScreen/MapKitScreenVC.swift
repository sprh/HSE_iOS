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
    func onGetFood(points: [YMKGeoObjectCollectionItem])
}

final class MapKitScreenVC: UIViewController {
    private let interactor: IMapKitScreenInteractor
    private var drivingSession: YMKDrivingSession?
    private var hasMapObjects = false
    lazy var foodCollection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)

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
        viewModel.routeTypeSegmentedControl.addTarget(self, action: #selector(onRouteTypeChanged),
                                                      for: .valueChanged)
        viewModel.minusButton.addTarget(self, action: #selector(onTapMinus), for: .touchUpInside)
        viewModel.plusButton.addTarget(self, action: #selector(onTapPlus), for: .touchUpInside)
        viewModel.mapView.mapWindow.map.addCameraListener(with: self)
        viewModel.compassButton.addTarget(self, action: #selector(onTapCompass), for: .touchUpInside)
        viewModel.foodButton.addTarget(self, action: #selector(onTapFoodButton), for: .touchUpInside)
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

    @objc
    private func onTapMinus() {
        moveCamera(fromCameraPosition: mapView.mapWindow.map.cameraPosition, value: -0.3)
    }

    @objc
    private func onTapPlus() {
        moveCamera(fromCameraPosition: mapView.mapWindow.map.cameraPosition, value: 0.3)
    }

    @objc
    private func onTapCompass() {
        let map = mapView.mapWindow.map
        let cameraPosition = map.cameraPosition
        map.move(with: YMKCameraPosition(target: cameraPosition.target,
                                         zoom: cameraPosition.zoom,
                                         azimuth: 0,
                                         tilt: cameraPosition.tilt),
                 animationType: YMKAnimation(type: .smooth, duration: 1))
    }

    @objc
    private func onTapFoodButton() {
        interactor.searchForFood(region: mapView.mapWindow.focusRegion)
    }

    private func moveCamera(fromCameraPosition: YMKCameraPosition, value: Float = 0) {
        mapView.mapWindow.map.move(with: YMKCameraPosition(target: fromCameraPosition.target,
                                                           zoom: fromCameraPosition.zoom + value,
                                                           azimuth: fromCameraPosition.azimuth,
                                                           tilt: fromCameraPosition.tilt),
                                   animationType: YMKAnimation(type: .smooth, duration: 1))
    }

    private func getRoute() {
        guard let from = viewModel.fromTextField.text,
              let to = viewModel.toTextField.text,
              from != to else {
                  showError(errorMessage: "One of routes is nil or routes are the same")
                  return
              }
        interactor.getRoute(from: from, to: to, of: currentRouteType, region: mapView.mapWindow.focusRegion)
    }

    private func clear() {
        viewModel.mapView.mapWindow.map.mapObjects.clear()
        viewModel.fromTextField.text = ""
        viewModel.toTextField.text = ""
        hasMapObjects = false
        viewModel.goButton.isEnabled = false
        viewModel.clearButton.isEnabled = false
        viewModel.routeLenght.isHidden = true
    }

    private func showError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    private func moveCamera(routePoints: Route) {
        let boundingBox = YMKBoundingBox(southWest: routePoints.from, northEast: routePoints.to)
        moveCamera(fromCameraPosition: mapView.mapWindow.map.cameraPosition(with: boundingBox),
                   value: -0.3)
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

    private func addPlacemarks(for points: [YMKPoint], images: [UIImage?]) {
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
        let mapObjects = mapView.mapWindow.map.mapObjects
        let polyline = mapObjects.addColoredPolyline(with: route.geometry)
        YMKRouteHelper.updatePolyline(withPolyline: polyline,
                                      route: route,
                                      style: YMKJamStyle(colors: [YMKJamTypeColor(jamType: .blocked, jam: .red),
                                                                  YMKJamTypeColor(jamType: .hard, jam: .systemYellow),
                                                                  YMKJamTypeColor(jamType: .free, jam: .green),
                                                                  YMKJamTypeColor(jamType: .light, jam: .systemGreen),
                                                                  YMKJamTypeColor(jamType: .unknown, jam: .gray)]))
        addPlacemarks(for: [routePoints.from, routePoints.to],
                         images: [UIImage(systemName: "a.circle.fill"),
                                  UIImage(systemName: "b.circle.fill")])
        moveCamera(routePoints: routePoints)
        viewModel.routeLenghtText.text = route.metadata.weight.distance.text
        viewModel.routeLenght.isHidden = false
    }

    func onGetRoute(routePoints: Route, route: YMKBicycleRoute) {
        clear()
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.addPolyline(with: route.geometry)
        addPlacemarks(for: [routePoints.from, routePoints.to],
                         images: [UIImage(systemName: "a.circle.fill"),
                                  UIImage(systemName: "b.circle.fill")])
        moveCamera(routePoints: routePoints)
        viewModel.routeLenghtText.text = route.weight.distance.text
        viewModel.routeLenght.isHidden = false
    }

    func onGetRoute(routePoints: Route, route: YMKMasstransitRoute) {
        clear()
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.addPolyline(with: route.geometry)
        addPlacemarks(for: [routePoints.from, routePoints.to],
                         images: [UIImage(systemName: "a.circle.fill"),
                                  UIImage(systemName: "b.circle.fill")])
        moveCamera(routePoints: routePoints)
        viewModel.routeLenghtText.text = route.metadata.weight.walkingDistance.text
        viewModel.routeLenght.isHidden = false
    }

    func onGetFood(points: [YMKGeoObjectCollectionItem]) {
        foodCollection.clear()
        hasMapObjects = true
        for searchResult in points {
            if let point = searchResult.obj?.geometry.first?.point {
                foodCollection.addPlacemark(with: point,
                                            image: UIImage(named: "food") ?? UIImage(),
                                            style: YMKIconStyle.init())
            }
        }
        foodCollection.clusterPlacemarks(withClusterRadius: 1, minZoom: 1)
    }
}

extension MapKitScreenVC: YMKMapCameraListener {
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition,
                                 cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        viewModel.compassButton.transform = CGAffineTransform(rotationAngle: CGFloat(cameraPosition.azimuth / 360))
    }
}

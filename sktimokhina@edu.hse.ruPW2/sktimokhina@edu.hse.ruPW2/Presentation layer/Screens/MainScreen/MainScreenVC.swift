//
//  MainScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit
import AVKit
import CoreLocation

protocol IMainScreenVC: UIViewController {
    var interactor: IMainScreenInteractor! { set get }

    func shouldShowSettings(userDefaults: IUserDefautsManager)
    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool)
}

final class MainScreenVC: UIViewController {
    var interactor: IMainScreenInteractor!
    private var router: IMainScreenRouter
    private var locationManager: CLLocationManager
    private var audioPlayer: AVAudioPlayer?

    private var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 20
        return stack
    }()

    private var location: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.font = UIFont.preferredFont(forTextStyle: .title1)
        location.numberOfLines = 0
        location.textAlignment = .center
        return location
    }()

    private var locationLabel: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.textAlignment = .center
        location.font = UIFont.preferredFont(forTextStyle: .title1)
        location.text = "Your location is.."
        return location
    }()
    
    init(router: IMainScreenRouter) {
        self.router = router
        locationManager = CLLocationManager()
        super.init(nibName: nil, bundle: nil)
        locationManager.requestWhenInUseAuthorization()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.shouldUpdateView()
        setupNavigationController()
        setupUI()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
    }

    private func setupUI() {
        view.addSubview(locationStack)
        locationStack.addSubview(location)
        locationStack.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: locationStack.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: locationStack.trailingAnchor),
            locationLabel.topAnchor.constraint(equalTo: locationStack.topAnchor, constant: 16),
            location.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            location.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            location.bottomAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: -16),

            locationStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func didTapSettingsButton() {
        if let audioData = NSDataAsset(name: "revelation_phase") {
            audioPlayer = try? AVAudioPlayer(data: audioData.data)
            audioPlayer?.play()
        }
        interactor.didTapSettingsButton()
    }
}

extension MainScreenVC: IMainScreenVC, ISettingsScreenObserver {
    func didUpdateSettings() {
        interactor.shouldUpdateView()
    }

    func shouldShowSettings(userDefaults: IUserDefautsManager) {
        router.showSettingsScreen(userDefaults: userDefaults, observer: self)
    }

    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool) {
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        view.backgroundColor = color
        if locationShown, CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy =
                kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
            location.text = "disabled("
        }
    }
}

extension MainScreenVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D =
                manager.location?.coordinate else {
            location.text = "Ops, can't find"
            return
        }
        location.text = "Coordinates: (\(coord.latitude) \(coord.longitude))"
    }
}

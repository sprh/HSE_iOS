//
//  MainScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit
import AVKit

protocol IMainScreenVC: UIViewController {
    var interactor: IMainScreenInteractor! { set get }

    func shouldShowSettings(userDefaults: IUserDefautsManager)
    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool)
}

final class MainScreenVC: UIViewController {
    var interactor: IMainScreenInteractor!
    private var router: IMainScreenRouter

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
        super.init(nibName: nil, bundle: nil)
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
        navigationItem.title = "Main"
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
    }

    private func setupUI() {
        view.addSubview(locationStack)
        locationStack.addSubview(location)
        locationStack.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: locationStack.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: locationStack.trailingAnchor, constant: -16),
            locationLabel.topAnchor.constraint(equalTo: locationStack.topAnchor, constant: 16),
            location.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            location.centerXAnchor.constraint(equalTo: locationLabel.centerXAnchor),
            location.bottomAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: -16),

            locationStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func didTapSettingsButton() {
        interactor.didTapSettingsButton()
    }
}

extension MainScreenVC: IMainScreenVC {
    func shouldShowSettings(userDefaults: IUserDefautsManager) {
        router.showSettingsScreen(userDefaults: userDefaults)
    }

    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool) {
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        view.backgroundColor = color
    }
}

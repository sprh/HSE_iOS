//
//  MainScreenRouter.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol IMainScreenRouter: AnyObject {
    func showSettingsScreen(userDefaults: IUserDefautsManager, observer: ISettingsScreenObserver)
}

final class MainScreenRouter: IMainScreenRouter {
    private var navigationController: UINavigationController
    private let transitioningDelegate = TransitioningDelegate()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showSettingsScreen(userDefaults: IUserDefautsManager, observer: ISettingsScreenObserver) {
        let graph = SettingsScreenGraph(userDefaults: userDefaults, observer: observer)
        let viewController = graph.viewController
        viewController.transitioningDelegate = transitioningDelegate
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .custom
        navigationController.present(viewController, animated: true)
    }
}

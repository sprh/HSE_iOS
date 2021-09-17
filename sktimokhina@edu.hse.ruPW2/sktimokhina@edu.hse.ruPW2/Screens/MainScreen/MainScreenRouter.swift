//
//  MainScreenRouter.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol IMainScreenRouter: AnyObject {
    func showSettingsScreen()
}

final class MainScreenRouter: IMainScreenRouter {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showSettingsScreen() {
        let graph = SettingsScreenGraph()
        navigationController.present(graph.viewController, animated: true)
    }
}

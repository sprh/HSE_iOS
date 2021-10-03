//
//  TabBarController.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 16.09.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .systemOrange
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear

        viewControllers = [createCarVC(), createShapesVC()]
    }

    private func createShapesVC() -> UIViewController {
        let viewController = ShapesViewController()
        viewController.tabBarItem.title = "Shapes"
        viewController.tabBarItem.image = .rectangleBordered
        viewController.tabBarItem.selectedImage = .rectangle
        return viewController
    }

    private func createCarVC() -> UIViewController {
        let viewController = CarViewController()
        viewController.tabBarItem.title = "Car"
        viewController.tabBarItem.image = .carBordered
        viewController.tabBarItem.selectedImage = .car
        return viewController
    }
}


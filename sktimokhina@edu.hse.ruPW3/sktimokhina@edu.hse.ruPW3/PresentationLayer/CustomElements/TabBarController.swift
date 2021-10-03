//
//  TabBarController.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .systemOrange
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear
        addViewControllers()
    }

    private func addViewControllers() {
    }
}

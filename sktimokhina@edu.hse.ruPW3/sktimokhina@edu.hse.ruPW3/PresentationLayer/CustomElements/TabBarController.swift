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
        tabBar.backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        addViewControllers()
    }

    private func addViewControllers() {
        viewControllers = [createCollectionVC()]
    }

    private func createCollectionVC() -> UIViewController {
        let collectionGraphVC = CollectionGraph().viewController
        collectionGraphVC.tabBarItem.title = "Collection"
        return collectionGraphVC
    }
}

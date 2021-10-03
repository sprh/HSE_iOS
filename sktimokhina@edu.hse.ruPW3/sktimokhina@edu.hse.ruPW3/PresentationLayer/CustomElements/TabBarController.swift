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
        viewControllers = [createCollectionVC(), createTableVC(), createStackVC()]
    }

    private func createCollectionVC() -> UIViewController {
        let collectionVC = CollectionGraph().viewController
        collectionVC.tabBarItem.title = "Collection"
        return collectionVC
    }

    private func createTableVC() -> UIViewController {
        let tableVC = TableGraph().viewController
        tableVC.tabBarItem.title = "Table"
        return tableVC
    }

    private func createStackVC() -> UIViewController {
        let stackVC = StackGraph().viewController
        stackVC.tabBarItem.title = "Table"
        return stackVC
    }
}

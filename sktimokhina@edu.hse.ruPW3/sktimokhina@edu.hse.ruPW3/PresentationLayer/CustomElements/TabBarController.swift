//
//  TabBarController.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    lazy var stackVC: UIViewController = {
        let stackVC = StackGraph().viewController
        stackVC.tabBarItem.title = "Stack"
        stackVC.tabBarItem.image = UIImage(systemName: "i.circle")
        stackVC.tabBarItem.selectedImage = UIImage(systemName: "i.circle.fill")
        return stackVC
    }()

    lazy var collectionVC: UIViewController = {
        let collectionVC = CollectionGraph().viewController
        collectionVC.tabBarItem.title = "Collection"
        collectionVC.tabBarItem.image = UIImage(systemName: "h.circle")
        collectionVC.tabBarItem.selectedImage = UIImage(systemName: "h.circle.fill")
        return collectionVC
    }()

    lazy var tableVC: UIViewController = {
        let tableVC = TableGraph().viewController
        tableVC.tabBarItem.title = "Table"
        tableVC.tabBarItem.image = UIImage(systemName: "exclamationmark")
        tableVC.tabBarItem.selectedImage = UIImage(systemName: "exclamationmark.3")
        return tableVC
    }()

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
        viewControllers = [collectionVC, stackVC, tableVC]
    }
}

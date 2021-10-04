//
//  TabBarController.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit
import CoreData

final class TabBarController: UITabBarController {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackVC: UINavigationController = {
        let stackVC = StackGraph(context: context).viewController
        stackVC.tabBarItem.title = "Stack"
        stackVC.tabBarItem.image = UIImage(systemName: "i.circle")
        stackVC.tabBarItem.selectedImage = UIImage(systemName: "i.circle.fill")
        return UINavigationController(rootViewController: stackVC)
    }()

    lazy var collectionVC: UINavigationController = {
        let collectionVC = CollectionGraph(context: context).viewController
        collectionVC.tabBarItem.title = "Collection"
        collectionVC.tabBarItem.image = UIImage(systemName: "h.circle")
        collectionVC.tabBarItem.selectedImage = UIImage(systemName: "h.circle.fill")
        return UINavigationController(rootViewController: collectionVC)
    }()

    lazy var tableVC: UINavigationController = {
        let tableVC = TableGraph(context: context).viewController
        tableVC.tabBarItem.title = "Table"
        tableVC.tabBarItem.image = UIImage(systemName: "exclamationmark")
        tableVC.tabBarItem.selectedImage = UIImage(systemName: "exclamationmark.3")
        return UINavigationController(rootViewController: tableVC)
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

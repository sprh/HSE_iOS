//
//  AppDelegate.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        let graph = MainScreenGraph(navigationController: navigationController)
        window = UIWindow()
        window?.rootViewController = navigationController
        navigationController.pushViewController(graph.viewController, animated: true)
        window?.makeKeyAndVisible()
        return true
    }
}


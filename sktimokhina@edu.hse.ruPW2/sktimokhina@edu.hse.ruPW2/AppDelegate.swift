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
        let graph = MainScreenGraph()
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: graph.viewController)
        window?.makeKeyAndVisible()
        return true
    }
}


//
//  AppDelegate.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        let graph = MapKitScreenGraph()
        window?.rootViewController = UINavigationController(rootViewController: graph.viewController)
        window?.makeKeyAndVisible()
        return true
    }
}


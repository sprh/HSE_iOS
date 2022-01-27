//
//  AppDelegate.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey("6254c4a4-c951-457d-a9b5-3953ff6351ce")
        YMKMapKit.initialize()
        window = UIWindow()

        let graph = MapKitScreenGraph()
        window?.rootViewController = UINavigationController(rootViewController: graph.viewController)
        window?.makeKeyAndVisible()
        return true
    }
}


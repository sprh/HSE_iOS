//
//  AppDelegate.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import UIKit
import YandexMapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey("66dd1c61-dc87-48cb-807b-c560e6dc582b")
        window = UIWindow()

        let graph = MapKitScreenGraph()
        window?.rootViewController = UINavigationController(rootViewController: graph.viewController)
        window?.makeKeyAndVisible()
        return true
    }
}


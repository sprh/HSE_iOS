//
//  UserDefaultsManager.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 18.09.2021.
//

import UIKit

protocol IUserDefautsManager: AnyObject {
    func set<T>(for key: UserDefaultsManager.Keys, value: T)
    func get<T>(for key: UserDefaultsManager.Keys) -> T?
}

final class UserDefaultsManager: IUserDefautsManager {
    enum Keys: String {
        case redColor = "RedColor"
        case greenColor = "GreenColor"
        case blueColor = "BlueColor"
        case showLocation = "Location"

        enum `Type` {
            case bool
            case string
        }

        func getType(for key: Keys) -> Type {
            switch key {
            case .redColor,
                 .greenColor,
                 .blueColor:
                return Type.string
            case .showLocation:
                return Type.bool
            }
        }
    }

    private let defaults: UserDefaults

    init() {
        defaults = UserDefaults.standard
    }

    func set<T>(for key: Keys, value: T) {
        defaults.setValue(value, forKey: key.rawValue)
    }

    func get<T>(for key: Keys) -> T? {
        defaults.object(forKey: key.rawValue) as? T
    }
}

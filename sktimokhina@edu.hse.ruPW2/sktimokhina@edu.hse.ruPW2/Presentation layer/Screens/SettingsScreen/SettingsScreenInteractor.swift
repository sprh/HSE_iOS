//
//  SettingsScreenInteractor.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import Foundation

protocol ISettingsScreenInteractor: AnyObject {
    func didUpdate<T>(for key: UserDefaultsManager.Keys, newValue: T)
}

final class SettingsScreenInteractor: ISettingsScreenInteractor {
    private var presenter: ISettingsScreenPresenter
    private var userDefaults: IUserDefautsManager

    init(presenter: ISettingsScreenPresenter,
         userDefaults: IUserDefautsManager) {
        self.presenter = presenter
        self.userDefaults = userDefaults
    }

    func didUpdate<T>(for key: UserDefaultsManager.Keys, newValue: T) {
        switch key {
        case .redColor:
            userDefaults.set(for: .redColor, value: newValue)
        case .greenColor:
            userDefaults.set(for: .greenColor, value: newValue)
        case .blueColor:
            userDefaults.set(for: .blueColor, value: newValue)
        case .showLocation:
            userDefaults.set(for: .showLocation, value: newValue)
        }
        presenter.shouldNotifyObserver()
    }
}

//
//  MainScreenPresenter.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import Foundation

protocol IMainScreenPresenter: AnyObject {
    func shouldShowSettings(userDefaults: IUserDefautsManager)
    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool)
}

final class MainScreenPresenter: IMainScreenPresenter {
    private var viewController: IMainScreenVC

    init(viewController: IMainScreenVC) {
        self.viewController = viewController
    }

    func shouldShowSettings(userDefaults: IUserDefautsManager) {
        viewController.shouldShowSettings(userDefaults: userDefaults)
    }

    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool) {
        viewController.shouldUpdateView(red: red, green: green, blue: blue, locationShown: locationShown)
    }
}

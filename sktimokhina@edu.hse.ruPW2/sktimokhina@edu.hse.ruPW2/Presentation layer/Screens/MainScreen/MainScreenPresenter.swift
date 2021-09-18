//
//  MainScreenPresenter.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import Foundation

protocol IMainScreenPresenter: AnyObject {
    func shouldShowSettings(userDefaults: IUserDefautsManager)
}

final class MainScreenPresenter: IMainScreenPresenter {
    private var viewController: IMainScreenVC

    init(viewController: IMainScreenVC) {
        self.viewController = viewController
    }

    func shouldShowSettings(userDefaults: IUserDefautsManager) {
        viewController.shouldShowSettings(userDefaults: userDefaults)
    }
}

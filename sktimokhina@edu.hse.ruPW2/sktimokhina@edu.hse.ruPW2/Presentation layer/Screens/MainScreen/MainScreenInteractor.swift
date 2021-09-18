//
//  MainScreenInteractor.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import Foundation

protocol IMainScreenInteractor: AnyObject {
    func didTapSettingsButton()
}

final class MainScreenInteractor: IMainScreenInteractor {
    private var presenter: IMainScreenPresenter
    private var userDefaults: IUserDefautsManager

    init(presenter: IMainScreenPresenter, userDefaults: IUserDefautsManager) {
        self.presenter = presenter
        self.userDefaults = userDefaults
    }

    func didTapSettingsButton() {
        presenter.shouldShowSettings(userDefaults: userDefaults)
    }
}

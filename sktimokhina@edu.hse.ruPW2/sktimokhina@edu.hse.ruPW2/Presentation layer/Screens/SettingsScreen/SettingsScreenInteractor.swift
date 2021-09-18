//
//  SettingsScreenInteractor.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import Foundation

protocol ISettingsScreenInteractor: AnyObject {
}

final class SettingsScreenInteractor: ISettingsScreenInteractor {
    private var presenter: ISettingsScreenPresenter
    private var userDefaults: IUserDefautsManager

    init(presenter: ISettingsScreenPresenter, userDefaults: IUserDefautsManager) {
        self.presenter = presenter
        self.userDefaults = userDefaults
    }
}

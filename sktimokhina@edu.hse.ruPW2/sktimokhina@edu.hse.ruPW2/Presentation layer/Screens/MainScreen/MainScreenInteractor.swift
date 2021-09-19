//
//  MainScreenInteractor.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import Foundation

protocol IMainScreenInteractor: AnyObject {
    func didTapSettingsButton()
    func shouldUpdateView()
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

    func shouldUpdateView() {
        presenter.shouldUpdateView(red: userDefaults.get(for: .redColor) ?? 0.0,
                                   green: userDefaults.get(for: .greenColor) ?? 0.0,
                                   blue: userDefaults.get(for: .redColor) ?? 0.0,
                                   locationShown: userDefaults.get(for: .showLocation) ?? true)
    }
}

//
//  SettingsScreenPresenter.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol ISettingsScreenPresenter: AnyObject {
    func shouldNotifyObserver()
    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool)
}

final class SettingsScreenPresenter: ISettingsScreenPresenter {
    private var viewController: ISettingsScreenVC

    init(viewController: ISettingsScreenVC) {
        self.viewController = viewController
    }

    func shouldNotifyObserver() {
        viewController.notifyObserver()
    }

    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool) {
        viewController.shouldUpdateView(red: red, green: green, blue: blue, locationShown: locationShown)
    }
}

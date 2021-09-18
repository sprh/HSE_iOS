//
//  SettingsScreenPresenter.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol ISettingsScreenPresenter: AnyObject {
    func updateSaveButton(red: Double, green: Double, blue: Double)
}

final class SettingsScreenPresenter: ISettingsScreenPresenter {
    private var viewController: ISettingsScreenVC

    init(viewController: ISettingsScreenVC) {
        self.viewController = viewController
    }

    func updateSaveButton(red: Double, green: Double, blue: Double) {
        viewController.updateSaveButton(red: red, green: green, blue: blue)
    }
}

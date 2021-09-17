//
//  SettingsScreenGraph.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

final class SettingsScreenGraph {
    private var presenter: ISettingsScreenPresenter
    private var interactor: ISettingsScreenInteractor
    private var view: ISettingsScreenVC

    init() {
        view = SettingsScreenVC()
        presenter = SettingsScreenPresenter(viewController: view)
        interactor = SettingsScreenInteractor(presenter: presenter)
        view.interactor = interactor
    }
}

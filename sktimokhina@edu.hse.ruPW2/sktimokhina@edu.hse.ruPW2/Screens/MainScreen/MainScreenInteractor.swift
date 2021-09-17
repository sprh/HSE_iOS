//
//  MainScreenInteractor.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import Foundation

protocol IMainScreenInteractor: AnyObject {
}

final class MainScreenInteractor: IMainScreenInteractor {
    private var presenter: IMainScreenPresenter

    init(presenter: IMainScreenPresenter) {
        self.presenter = presenter
    }
}

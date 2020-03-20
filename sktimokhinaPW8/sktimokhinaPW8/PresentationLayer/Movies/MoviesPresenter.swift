//
//  MoviesPresenter.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation

protocol IMoviesPresenter {
    var viewController: IMoviesVC? { get set }

    func updateTableView()
    func showError(_ error: String)
}

final class MoviesPresenter: IMoviesPresenter {
    weak var viewController: IMoviesVC?

    func updateTableView() {
        viewController?.updateTableView()
    }

    func showError(_ error: String) {
        viewController?.showError(error)
    }
}

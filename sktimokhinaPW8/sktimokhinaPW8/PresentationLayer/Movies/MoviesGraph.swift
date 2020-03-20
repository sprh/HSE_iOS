//
//  MoviesGraph.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import UIKit
import CoreData

final class MoviesGraph {
    private let view: IMoviesVC
    private let interactor: IMoviesInteractor
    private var presenter: IMoviesPresenter
    private var router: IMoviesRouter

    var viewController: UIViewController {
        view
    }

    init() {
        presenter = MoviesPresenter()
        interactor = MoviesInteractor(presenter: presenter)
        router = MoviesViewRouter()
        view = MoviesVC(interactor: interactor, router: router)
        presenter.viewController = view
        router.viewController = view
    }
}

//
//  MoviesRouter.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import UIKit

protocol IMoviesRouter {
    var viewController: IMoviesVC? { get set }

    func showError(_ error: String)
}

final class MoviesViewRouter: IMoviesRouter {
    weak var viewController: IMoviesVC?

    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error(",
                                      message: error,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

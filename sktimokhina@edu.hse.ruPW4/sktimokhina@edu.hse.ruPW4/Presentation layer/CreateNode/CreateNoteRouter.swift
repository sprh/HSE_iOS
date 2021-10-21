//
//  CreateNoteRouter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol ICreateNoteRouter {
    var viewController: ICreateNoteVC? { get set }

    func showError(message: String)
}

final class CreateNoteViewRouter: ICreateNoteRouter {
    weak var viewController: ICreateNoteVC?

    func showError(message: String) {
        let alert = UIAlertController(title: "Ops, can't save", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController?.present(alert, animated: true)
    }
}

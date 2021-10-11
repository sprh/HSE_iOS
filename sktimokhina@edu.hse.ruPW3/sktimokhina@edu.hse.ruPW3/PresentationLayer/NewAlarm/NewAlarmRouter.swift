//
//  NewAlarmViewRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

protocol INewAlarmRouter {
    var viewController: INewAlarmVC? { get set }

    func showError()
}

final class NewAlarmViewRouter: INewAlarmRouter {
    weak var viewController: INewAlarmVC?

    func showError() {
        let alert = UIAlertController(title: "Ops, can't save", message: "Ops, can't save", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        viewController?.present(alert, animated: true)
    }
}

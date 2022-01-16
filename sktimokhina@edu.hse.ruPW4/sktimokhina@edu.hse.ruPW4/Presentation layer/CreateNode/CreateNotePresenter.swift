//
//  CreateNotePresenter.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import Foundation

protocol ICreateNotePresenter {
    var viewController: ICreateNoteVC? { get set }

    func shouldShowError(message: String)
    func shouldClose()
    func update(description: String, title: String, status: Int)

}

final class CreateNotePresenter: ICreateNotePresenter {
    weak var viewController: ICreateNoteVC?

    func shouldClose() {
        viewController?.shouldClose()
    }

    func shouldShowError(message: String) {
        viewController?.shouldShowError(message: message)
    }

    func update(description: String, title: String, status: Int) {
        viewController?.update(description: description, title: title, status: status)
    }
}

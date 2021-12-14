//
//  NewAlarmPresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol INewAlarmPresenter {
    var viewController: INewAlarmVC? { get set }

    func shouldShowError()
    func shouldClose()
    func update(description: String, time: Date, isOn: Bool)
}

final class NewAlarmPresenter: INewAlarmPresenter {
    weak var viewController: INewAlarmVC?

    func shouldClose() {
        viewController?.shouldClose()
    }

    func shouldShowError() {
        viewController?.shouldShowError()
    }

    func update(description: String, time: Date, isOn: Bool) {
        viewController?.update(description: description, time: time, isOn: isOn)
    }
}

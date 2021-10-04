//
//  NewAlarmPresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol INewAlarmPresenter {
    var viewController: INewAlarmVC? { get set }
}

final class NewAlarmPresenter: INewAlarmPresenter {
    weak var viewController: INewAlarmVC?
}

//
//  NewAlarmViewRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol INewAlarmRouter {
    var viewController: INewAlarmVC? { get set }
}

final class NewAlarmViewRouter: INewAlarmRouter {
    weak var viewController: INewAlarmVC?
}

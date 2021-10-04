//
//  AlarmsListRouter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

protocol IAlarmsRouter {
    var viewController: IAlarmsVC? { get set }
}

final class AlarmsViewRouter: IAlarmsRouter {
    weak var viewController: IAlarmsVC?
}


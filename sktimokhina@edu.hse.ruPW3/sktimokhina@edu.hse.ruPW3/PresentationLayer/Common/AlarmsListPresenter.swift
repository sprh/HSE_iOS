//
//  AlarmsListPresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

import Foundation

protocol IAlarmsPresenter {
    var viewController: IAlarmsVC? { get set }
}

final class AlarmsPresenter: IAlarmsPresenter {
    weak var viewController: IAlarmsVC?
}

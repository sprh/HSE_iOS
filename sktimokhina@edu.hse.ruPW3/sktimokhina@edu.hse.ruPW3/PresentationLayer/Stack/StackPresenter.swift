//
//  StackPresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol IStackPresenter {
    var viewController: IStackVC? { get set }
}

final class StackPresenter: IStackPresenter {
    weak var viewController: IStackVC?
}

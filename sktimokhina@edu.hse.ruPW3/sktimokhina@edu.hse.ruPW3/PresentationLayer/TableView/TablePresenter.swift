//
//  TablePresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol ITablePresenter {
    var viewController: ITableVC? { get set }
}

final class TablePresenter: ITablePresenter {
    weak var viewController: ITableVC?
}

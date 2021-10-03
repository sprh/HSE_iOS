//
//  СollectionPresenter.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol ICollectionPresenter {
    var viewController: ICollectionVC? { get set }
}

final class CollectionPresenter: ICollectionPresenter {
    weak var viewController: ICollectionVC?
}

//
//  MapKitScreenPresenter.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import Foundation

protocol IMapKitScreenPresenter {
    var viewController: IMapKitScreenVC? { get set }
}

final class MapKitScreenPresenter: IMapKitScreenPresenter {
    weak var viewController: IMapKitScreenVC?
}

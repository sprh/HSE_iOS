//
//  MapKitScreenInteractor.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//

import Foundation

protocol IMapKitScreenInteractor {

}

final class MapKitScreenInteractor: IMapKitScreenInteractor {
    private let presenter: IMapKitScreenPresenter

    init(presenter: IMapKitScreenPresenter) {
        self.presenter = presenter
    }
}

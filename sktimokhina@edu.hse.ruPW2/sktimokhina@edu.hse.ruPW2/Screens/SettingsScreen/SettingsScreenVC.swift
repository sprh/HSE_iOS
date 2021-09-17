//
//  SettingsScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol ISettingsScreenVC: UIViewController {
    var interactor: ISettingsScreenInteractor! { get set }
}

final class SettingsScreenVC: UIViewController, ISettingsScreenVC {
    var interactor: ISettingsScreenInteractor!
}

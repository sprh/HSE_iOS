//
//  NewAlarmVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

protocol INewAlarmVC: UIViewController {
}

final class NewAlarmVC: UIViewController, INewAlarmVC {
    private let interactor: INewAlarmInteractor

    init(interactor: INewAlarmInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
}

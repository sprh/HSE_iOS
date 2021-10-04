//
//  AlarmsVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class TableVC: UIViewController, IAlarmsVC {
    let interactor: IAlarmsInteractor
    let router: IAlarmsRouter

    init(interactor: IAlarmsInteractor, router: IAlarmsRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(didTapAddButton))
        createAlarmHeader(addButton, "Table")
    }

    @objc func didTapAddButton() {
        interactor.didTapNewAlarm()
    }
}

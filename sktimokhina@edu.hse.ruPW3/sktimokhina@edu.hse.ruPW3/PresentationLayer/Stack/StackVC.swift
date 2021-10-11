//
//  AlarmsListVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class StackVC: UIViewController, IAlarmsListVC {
    let interactor: IAlarmsListInteractor
    let router: IAlarmsListRouter

    init(interactor: IAlarmsListInteractor, router: IAlarmsListRouter) {
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
        let addButton = UIBarButtonItem(image: UIImage(systemName: ""),
                                        style: .plain,
                                        target: self,
                                        action: #selector(didTapAddButton))
        createAlarmHeader(addButton, "Stack")
    }

    func setAlarms() {

    }

    func showError() {
        
    }

    func didUpdateAlarm(with id: ObjectIdentifier) {
        
    }

    func didToggleIsOn(id: ObjectIdentifier, isOn: Bool) {
    }



    @objc func didTapAddButton() {
        interactor.didTapNewAlarm()
    }

    func didAddItem() {
    }

    func didUpdateItem(with id: ObjectIdentifier) {
    }
}

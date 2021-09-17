//
//  MainScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol IMainScreenVC: UIViewController {
    var interactor: IMainScreenInteractor! { set get }
}

final class MainScreenVC: UIViewController, IMainScreenVC {
    var interactor: IMainScreenInteractor!
    private var router: IMainScreenRouter
    
    init(router: IMainScreenRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

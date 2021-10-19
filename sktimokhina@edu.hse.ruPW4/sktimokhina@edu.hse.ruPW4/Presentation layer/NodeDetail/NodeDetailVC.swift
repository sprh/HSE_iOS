//
//  NodeDetailVC.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodeDetailVC: UIViewController {
}

final class NodeDetailVC: UIViewController, INodeDetailVC {
    private let interactor: INodeDetailInteractor
    private let router: INodeDetailRouter

    init(interactor: INodeDetailInteractor, router: INodeDetailRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
    }
}

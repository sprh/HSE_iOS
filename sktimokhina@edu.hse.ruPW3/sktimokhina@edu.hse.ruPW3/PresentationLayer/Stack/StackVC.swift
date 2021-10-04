//
//  StackVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

protocol IStackVC: UIViewController {
}

final class StackVC: UIViewController, IStackVC {
    private let interactor: IStackInteractor

    init(interactor: IStackInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let addButton = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: #selector(didTapAddButton))
        createAlarmHeader(addButton, "Stack")
    }

    @objc func didTapAddButton() {

    }
    
}

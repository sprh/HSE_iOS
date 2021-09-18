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

    private var settingsView: SettingsView = {
        let stack = SettingsView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9764078259, blue: 0.8245866895, alpha: 1)
        setupUI()
    }

    func setupUI() {
        view.addSubview(settingsView)
        settingsView.setupUI()

        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

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

    private var saveButton: UIButton = {
        let viewModel =
            MainButton.ViewModel(
                font: UIFont.preferredFont(forTextStyle: .headline),
                title: "Save",
                enabledTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                disabledTextColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        let button = MainButton(viewModel: viewModel)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9764078259, blue: 0.8245866895, alpha: 1)
        setupUI()
    }

    func setupUI() {
        view.addSubview(settingsView)
        view.addSubview(saveButton)
        settingsView.setupUI()

        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

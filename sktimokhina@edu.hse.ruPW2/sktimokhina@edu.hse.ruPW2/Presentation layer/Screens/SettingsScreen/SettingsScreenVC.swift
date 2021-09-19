//
//  SettingsScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol ISettingsScreenVC: UIViewController {
    var interactor: ISettingsScreenInteractor! { get set }
    func updateLocationSwitch(isOn: Bool)
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
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9705604911, blue: 0.7168341279, alpha: 1)
        setupUI()
        addTargets()
    }

    func setupUI() {
        view.addSubview(settingsView)
        settingsView.setupUI()

        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])

        settingsView.layoutIfNeeded()
        view.bounds.size.height = settingsView.bounds.height
    }

    func addTargets() {
        settingsView.redColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
        settingsView.greenColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
        settingsView.blueColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
    }

    func updateLocationSwitch(isOn: Bool) {
        settingsView.locationSwitch.isOn = isOn
    }

    @objc func didTapSaveButton() {
    }

    @objc func didUpdateColor(_ sender: ColorSlider) {
        switch sender.color {
        case .red:
            interactor.didUpdate(for: .redColor, newValue: sender.value)
        case .green:
            interactor.didUpdate(for: .greenColor, newValue: sender.value)
        case .blue:
            interactor.didUpdate(for: .blueColor, newValue: sender.value)
        }
    }
}

//
//  SettingsScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol ISettingsScreenVC: UIViewController {
    var interactor: ISettingsScreenInteractor! { get set }
    func updateSaveButton(red: Double, green: Double, blue: Double)
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

    private var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9764078259, blue: 0.8245866895, alpha: 1)
        setupUI()
        addTargets()
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

    func addTargets() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        settingsView.redColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
        settingsView.greenColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
        settingsView.blueColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
    }

    func updateSaveButton(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }

    func updateLocationSwitch(isOn: Bool) {
        settingsView.locationSwitch.isOn = isOn
    }

    func updateSaveButton(red: Double, green: Double, blue: Double) {
        saveButton.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
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

//
//  SettingsScreenVC.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 17.09.2021.
//

import UIKit

protocol ISettingsScreenObserver: AnyObject {
    func didUpdateSettings()}

protocol ISettingsScreenVC: UIViewController {
    var interactor: ISettingsScreenInteractor! { get set }
    var observer: ISettingsScreenObserver? { get set }
    func updateLocationSwitch(isOn: Bool)
    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool)
    func notifyObserver()
}

final class SettingsScreenVC: UIViewController, ISettingsScreenVC {
    var interactor: ISettingsScreenInteractor!
    weak var observer: ISettingsScreenObserver?

    private var settingsView: SettingsView = {
        let stack = SettingsView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        return stack
    }()

    private var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"),
                        for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9705604911, blue: 0.7168341279, alpha: 1)
        interactor.shouldUpdateView()
        setupUI()
        addTargets()
    }

    func setupUI() {
        view.addSubview(settingsView)
        view.addSubview(closeButton)
        settingsView.setupUI()

        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            settingsView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])

        view.setNeedsLayout()
        view.layoutIfNeeded()
        let fittingSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        view.bounds.size.height = fittingSize.height
    }

    func addTargets() {
        settingsView.redColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
        settingsView.greenColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
        settingsView.blueColorSlider.addTarget(self, action: #selector(didUpdateColor(_:)), for: .valueChanged)
        settingsView.locationSwitch.addTarget(self, action: #selector(didToggleLocation(_:)), for: .valueChanged)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }

    func updateLocationSwitch(isOn: Bool) {
        settingsView.locationSwitch.isOn = isOn
    }

    func notifyObserver() {
        observer?.didUpdateSettings()
    }

    func shouldUpdateView(red: Float, green: Float, blue: Float, locationShown: Bool) {
        settingsView.redColorSlider.value = red
        settingsView.greenColorSlider.value = green
        settingsView.blueColorSlider.value = blue
        settingsView.locationSwitch.isOn = locationShown
    }


    @objc func didTapCloseButton() {
        dismiss(animated: true)
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

    @objc func didToggleLocation(_ sender: UISwitch) {
        interactor.didUpdate(for: .showLocation, newValue: sender.isOn)
    }
}

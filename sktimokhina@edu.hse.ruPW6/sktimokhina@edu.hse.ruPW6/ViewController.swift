//
//  ViewController.swift
//  sktimokhina@edu.hse.ruPW6
//
//  Created by Софья Тимохина on 13.11.2021.
//

import UIKit
import MyLogger1

class ViewController: UIViewController {
    lazy var frameworkButton: UIButton = {
        let button = createButton(for: "Log (framework)")
        button.addTarget(self,
                         action: #selector(onTapFramework),
                         for: .touchUpInside)
        return button
    }()

    lazy var packageButton: UIButton = {
        let button = createButton(for: "Log (package)")
        button.addTarget(self,
                         action: #selector(onTapPachage),
                         for: .touchUpInside)
        return button
    }()

    lazy var podButton: UIButton = {
        let button = createButton(for: "Log (pod)")
        button.addTarget(self,
                         action: #selector(onTapPod),
                         for: .touchUpInside)
        return button
    }()

    lazy var carthageButton: UIButton = {
        let button = createButton(for: "Lon (carthage)")
        button.addTarget(self,
                         action: #selector(onTapCarthage),
                         for: .touchUpInside)
        return button
    }()

    private func createButton(for title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.titlePadding = 4.0
        config.baseBackgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        button.configuration = config
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9960667491, blue: 0.9126277566, alpha: 1)
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        stack.addSubview(frameworkButton)
        stack.addSubview(packageButton)
        stack.addSubview(podButton)
        stack.addSubview(carthageButton)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            frameworkButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            frameworkButton.heightAnchor.constraint(equalToConstant: 55),
            frameworkButton.topAnchor.constraint(equalTo: stack.topAnchor),

            packageButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            packageButton.heightAnchor.constraint(equalToConstant: 55),
            packageButton.topAnchor.constraint(equalTo: frameworkButton.bottomAnchor,
                                              constant: 16),

            podButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            podButton.heightAnchor.constraint(equalToConstant: 55),
            podButton.topAnchor.constraint(equalTo: packageButton.bottomAnchor,
                                              constant: 16),

            carthageButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            carthageButton.heightAnchor.constraint(equalToConstant: 55),
            carthageButton.topAnchor.constraint(equalTo: podButton.bottomAnchor,
                                              constant: 16),
            carthageButton.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])
    }

    @objc
    func onTapFramework() {
        MyLogger1.log("Did tap framework button!")
    }

    @objc
    func onTapPachage() {

    }

    @objc
    func onTapPod() {

    }

    @objc
    func onTapCarthage() {

    }

    @objc func onPress(_ selector: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            selector.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            selector.alpha = 0.8
        }, completion: {finished in
            if finished {
                selector.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                selector.alpha = 1
            }
        })
    }
}


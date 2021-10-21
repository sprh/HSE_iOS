//
//  CreateNodeVC.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol ICreateNodeVC: UIViewController {
    func shouldShowError(message: String)
    func shouldClose()
}

final class CreateNodeVC: UIViewController, ICreateNodeVC {
    private let interactor: ICreateNodeInteractor
    private let router: ICreateNodeRouter

    private let doneButtonEnabledColor = #colorLiteral(red: 0.7895931005, green: 0.3977047205, blue: 0.5209977627, alpha: 1)
    private let doneButtonDisabledColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        button.isEnabled = false
        button.setTitleColor(doneButtonDisabledColor, for: .normal)
        return button
    }()
    lazy var createNodeView: CreateNodeView = {
        let view = CreateNodeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(interactor: ICreateNodeInteractor, router: ICreateNodeRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createNodeView.setScrollViewContentSize()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        view.addSubview(createNodeView)
        NSLayoutConstraint.activate([
            createNodeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createNodeView.topAnchor.constraint(equalTo: view.topAnchor),
            createNodeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            createNodeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        createNodeView.titleTextView.delegate = self
        createNodeView.descriptionTextView.delegate = self
    }

    @objc
    func didTapAddButton() {
        interactor.saveNode(title: createNodeView.titleTextView.text, description: createNodeView.descriptionTextView.text, importance: Int32(createNodeView.segmentedControl.selectedSegmentIndex))
    }

    func shouldShowError(message: String) {
        router.showError(message: message)
    }

    func shouldClose() {
        navigationController?.popViewController(animated: true)
    }
}

extension CreateNodeVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        doneButton.isEnabled = !createNodeView.titleTextView.text.isEmpty && !createNodeView.descriptionTextView.text.isEmpty
        doneButton.setTitleColor(doneButton.isEnabled ? doneButtonEnabledColor : doneButtonDisabledColor, for: .normal)
    }
}

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
        createNodeView.saveButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
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
        createNodeView.saveButton.isEnabled = !createNodeView.titleTextView.text.isEmpty && !createNodeView.descriptionTextView.text.isEmpty
    }
}

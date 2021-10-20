//
//  NodeDetailVC.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodeDetailVC: UIViewController {
    func shouldShowError(message: String)
    func shouldClose()
}

final class NodeDetailVC: UIViewController, INodeDetailVC {
    private let interactor: INodeDetailInteractor
    private let router: INodeDetailRouter

    lazy var nodeDetailView: NodeDetailView = {
        let view = NodeDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(interactor: INodeDetailInteractor, router: INodeDetailRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nodeDetailView.setScrollViewContentSize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        view.addSubview(nodeDetailView)
        NSLayoutConstraint.activate([
            nodeDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nodeDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            nodeDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nodeDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        nodeDetailView.saveButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        nodeDetailView.titleTextView.delegate = self
        nodeDetailView.descriptionTextView.delegate = self
    }

    @objc
    func didTapAddButton() {
        interactor.saveNode(title: nodeDetailView.titleTextView.text, description: nodeDetailView.descriptionTextView.text, importance: Int32(nodeDetailView.segmentedControl.selectedSegmentIndex))
    }

    func shouldShowError(message: String) {
        router.showError(message: message)
    }

    func shouldClose() {
        navigationController?.popViewController(animated: true)
    }
}

extension NodeDetailVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        nodeDetailView.saveButton.isEnabled = !nodeDetailView.titleTextView.text.isEmpty && !nodeDetailView.descriptionTextView.text.isEmpty
    }
}

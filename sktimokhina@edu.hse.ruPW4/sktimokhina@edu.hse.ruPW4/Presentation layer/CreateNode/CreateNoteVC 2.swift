//
//  CreateNoteVC.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol ICreateNoteVC: UIViewController {
    func shouldShowError(message: String)
    func shouldClose()
    func update(description: String, title: String, status: Int)

}

final class CreateNoteVC: UIViewController, ICreateNoteVC {
    private let interactor: ICreateNoteInteractor
    private let router: ICreateNoteRouter

    private let doneButtonEnabledColor = #colorLiteral(red: 0.7895931005, green: 0.3977047205, blue: 0.5209977627, alpha: 1)
    private let doneButtonDisabledColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Done",
                                     style: .done,
                                     target: self,
                                     action: #selector(didTapAddButton))
        button.isEnabled = false
        button.tintColor = doneButtonDisabledColor
        return button
    }()
    lazy var createNoteView: CreateNoteView = {
        let view = CreateNoteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(interactor: ICreateNoteInteractor, router: ICreateNoteRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createNoteView.setScrollViewContentSize()
        navigationItem.rightBarButtonItem = doneButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.updateIfNeeded()
        setup()
    }

    private func setup() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        view.addSubview(createNoteView)
        NSLayoutConstraint.activate([
            createNoteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createNoteView.topAnchor.constraint(equalTo: view.topAnchor),
            createNoteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            createNoteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        createNoteView.titleTextView.delegate = self
        createNoteView.descriptionTextView.delegate = self
    }

    @objc
    func didTapAddButton() {
        interactor.saveNote(title: createNoteView.titleTextView.text, description: createNoteView.descriptionTextView.text, status: Int32(createNoteView.segmentedControl.selectedSegmentIndex))
    }

    func shouldShowError(message: String) {
        router.showError(message: message)
    }

    func shouldClose() {
        navigationController?.popViewController(animated: true)
    }

    func update(description: String, title: String, status: Int) {
        createNoteView.titleTextView.text = title
        createNoteView.descriptionTextView.text = description
        createNoteView.segmentedControl.selectedSegmentIndex = status
    }
}

extension CreateNoteVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        doneButton.isEnabled = !createNoteView.titleTextView.text.isEmpty && !createNoteView.descriptionTextView.text.isEmpty
        doneButton.tintColor = doneButton.isEnabled ? doneButtonEnabledColor : doneButtonDisabledColor
    }
}

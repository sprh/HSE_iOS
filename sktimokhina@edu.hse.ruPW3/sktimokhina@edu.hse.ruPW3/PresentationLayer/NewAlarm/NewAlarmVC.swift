//
//  NewAlarmVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

protocol INewAlarmVC: UIViewController {
}

final class NewAlarmVC: UIViewController, INewAlarmVC {
    private let interactor: INewAlarmInteractor
    private let router: INewAlarmRouter

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = .systemFont(ofSize: 22)
        return label
    }()

    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .red
        textView.autoresizingMask = .flexibleBottomMargin
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 16
        textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        textView.becomeFirstResponder()
        return textView
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = .systemFont(ofSize: 22)
        return label
    }()

    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .red
        textView.autoresizingMask = .flexibleBottomMargin
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 16
        textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        textView.becomeFirstResponder()
        return textView
    }()

    lazy var saveButton: UIButton = {
        let model = MainButton.ViewModel(font: UIFont.preferredFont(forTextStyle: .body),
                                         title: "Save",
                                         enabledTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                         disabledTextColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        let button = MainButton(frame: .zero, viewModel: model)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.9705604911, blue: 0.7168341279, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.layer.cornerRadius = 20
        return button
    }()


    lazy var onLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Is on"
        label.font = .systemFont(ofSize: 22)
        return label
    }()

    lazy var onSwitch: UISwitch = {
        let onSwitch = UISwitch()
        onSwitch.translatesAutoresizingMaskIntoConstraints = false
        onSwitch.onTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return onSwitch
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    init(interactor: INewAlarmInteractor, router: INewAlarmRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewContentSize()
    }

    func setup() {
        keyboardWillShow(scrollView)
        keyboardWillHide(scrollView)
        hideKeyboardWhenTappedAround()
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleTextView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(saveButton)
        scrollView.addSubview(onSwitch)
        scrollView.addSubview(onLabel)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleTextView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            titleTextView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            onLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            onLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            onSwitch.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            onSwitch.centerYAnchor.constraint(equalTo: onLabel.centerYAnchor),
            saveButton.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: onSwitch.bottomAnchor, constant: 16),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
        ])

    }

    func setScrollViewContentSize() {
        scrollView.contentSize.height = scrollView.convert(saveButton.frame.origin, to: scrollView).y +
            UIViewController.safeAreaHeight()
    }
    
}

extension NewAlarmVC: UITextViewDelegate {
    @objc func textDidChangeNotification() {
        setScrollViewContentSize()
    }
}

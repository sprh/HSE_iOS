//
//  CreateNoteView.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

final class CreateNoteView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autoresizingMask = .flexibleBottomMargin
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 16
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        textView.becomeFirstResponder()
        return textView
    }()
    lazy var descriprionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autoresizingMask = .flexibleBottomMargin
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 16
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        textView.becomeFirstResponder()
        return textView
    }()

    lazy var statusAndDateStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 16
        stack.isUserInteractionEnabled = true
        return stack
    }()

    lazy var labelStatus: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var deadlineSwitch = UISwitch()
    var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["done", "waiting", "new", "other"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()


    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()

    let standartColorButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        keyboardWillShow(scrollView)
        keyboardWillHide(scrollView)
        hideKeyboardWhenTappedAround()

        setupStatusAndDateStack()
        setupScrollview()
    }

    private func setupStatusAndDateStack() {
        statusAndDateStack.addSubview(labelStatus)
        statusAndDateStack.addSubview(segmentedControl)
        statusAndDateStack.addSubview(labelStatus)
        NSLayoutConstraint.activate([
            labelStatus.leadingAnchor.constraint(equalTo: statusAndDateStack.leadingAnchor, constant: 16),
            labelStatus.topAnchor.constraint(equalTo: statusAndDateStack.topAnchor, constant: 17),
            segmentedControl.trailingAnchor.constraint(equalTo: statusAndDateStack.trailingAnchor, constant: -12),
            segmentedControl.topAnchor.constraint(equalTo: statusAndDateStack.topAnchor, constant: 10),
            segmentedControl.bottomAnchor.constraint(equalTo: statusAndDateStack.bottomAnchor, constant: 16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func setupScrollview() {
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(statusAndDateStack)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleTextView)
        scrollView.addSubview(descriprionLabel)
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),

            titleTextView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),

            descriprionLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriprionLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriprionLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 16),

            descriptionTextView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionTextView.topAnchor.constraint(equalTo: descriprionLabel.bottomAnchor, constant: 16),

            statusAndDateStack.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            statusAndDateStack.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statusAndDateStack.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

    func setScrollViewContentSize() {
        scrollView.contentSize.height = scrollView.convert(statusAndDateStack.frame.origin, to: scrollView).y + UIView.safeAreaHeight()
    }
}

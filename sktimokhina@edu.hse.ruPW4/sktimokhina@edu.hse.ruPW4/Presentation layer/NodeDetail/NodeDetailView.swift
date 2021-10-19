//
//  NodeDetailView.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

final class NodeDetailView: UIView {
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autoresizingMask = .flexibleBottomMargin
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 16
        textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .red
        textView.becomeFirstResponder()
        return textView
    }()

    lazy var importanceAndDateStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 16
        stack.isUserInteractionEnabled = true
        return stack
    }()

    lazy var labelImportance: UILabel = {
        let label = UILabel()
        label.text = "Importance"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var deadlineSwitch = UISwitch()
    var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["low", "basic", "important"])
//        segmentedControl.setImage(.lowImportance, forSegmentAt: 0)
//        segmentedControl.setTitle("non", forSegmentAt: 1)
//        segmentedControl.setImage(.highImportance, forSegmentAt: 2)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        button.layer.cornerRadius = 16
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        button.layer.cornerRadius = 16
        return button
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

    func setup() {
        keyboardWillShow(scrollView)
        keyboardWillHide(scrollView)
        hideKeyboardWhenTappedAround()

        setupImportanceAndDateStack()
        setupScrollview()
    }

    private func setupImportanceAndDateStack() {
        importanceAndDateStack.addSubview(labelImportance)
        importanceAndDateStack.addSubview(segmentedControl)
        importanceAndDateStack.addSubview(labelImportance)
        NSLayoutConstraint.activate([
            labelImportance.leadingAnchor.constraint(equalTo: importanceAndDateStack.leadingAnchor, constant: 16),
            labelImportance.topAnchor.constraint(equalTo: importanceAndDateStack.topAnchor, constant: 17),
            segmentedControl.trailingAnchor.constraint(equalTo: importanceAndDateStack.trailingAnchor, constant: -12),
            segmentedControl.topAnchor.constraint(equalTo: importanceAndDateStack.topAnchor, constant: 10),
            segmentedControl.bottomAnchor.constraint(equalTo: importanceAndDateStack.bottomAnchor, constant: 16)
        ])
    }

    private func setupScrollview() {
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(importanceAndDateStack)
        scrollView.addSubview(saveButton)
        scrollView.addSubview(deleteButton)
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor),

            descriptionTextView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionTextView.topAnchor.constraint(equalTo: scrollView.topAnchor),

            importanceAndDateStack.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            importanceAndDateStack.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            importanceAndDateStack.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            saveButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: importanceAndDateStack.bottomAnchor, constant: 32),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            deleteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 32),
            deleteButton.heightAnchor.constraint(equalToConstant: 55),
            deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    func setScrollViewContentSize() {
        scrollView.contentSize.height = scrollView.convert(descriptionTextView.frame.origin, to: scrollView).y +
            100
    }
}

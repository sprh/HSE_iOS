//
//  AlarmsListVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class StackVC: UIViewController, IAlarmsListVC {
    let interactor: IAlarmsListInteractor
    let router: IAlarmsListRouter

    lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                               style: .done,
                               target: self,
                               action: #selector(didTapAddButton))
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()

    init(interactor: IAlarmsListInteractor, router: IAlarmsListRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        createAlarmHeader(addButton, "Stack")
        interactor.load()
    }

    private func setup() {
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

    func setAlarms() {
        stackView.subviews.forEach({ $0.removeFromSuperview()})
        scrollView.contentSize.height = 0
        for i in 0..<interactor.alarmsCount {
            let alarm = interactor.getAlarmAt(index: i)
            let alarmView = StackAlarmItem()
            alarmView.setup(with: alarm, observer: self)
            let systemLayoutSizeFitting = alarmView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            scrollView.contentSize.height += systemLayoutSizeFitting.height + 10
            stackView.addArrangedSubview(alarmView)
        }
    }

    func showError() {
        router.showError()
    }


    @objc func didTapAddButton() {
        interactor.didTapNewAlarm()
    }
}

extension StackVC: IAlarmUpdaterObserver {
    func didToggleIsOn(id: ObjectIdentifier, isOn: Bool) {
        interactor.update(id: id, isOn: isOn)
    }

    func didAddItem() {
        interactor.prefetch { [weak self] in
            self?.setAlarms()
        }
    }

    func didUpdateItem(with id: ObjectIdentifier) {
        guard let view = stackView.subviews.first(where: { $0 is StackAlarmItem && ($0 as? StackAlarmItem)?.id == id}) as? StackAlarmItem else { return }
        view.update(with: interactor.getAlarm(with: id))
    }
}

//
//  AlarmsListVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class TableVC: UIViewController, IAlarmsListVC {
    let interactor: IAlarmsListInteractor
    let router: IAlarmsListRouter

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: "\(AlarmTableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = true
        tableView.delaysContentTouches = true
        tableView.canCancelContentTouches = true
        return tableView
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
        view.backgroundColor = .yellow
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(didTapAddButton))
        createAlarmHeader(addButton, "Table")
        view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.load()
    }

    @objc func didTapAddButton() {
        interactor.didTapNewAlarm()
    }

    func setAlarms() {

    }

    func showError() {
        
    }

    func didToggleIsOn(id: ObjectIdentifier, isOn: Bool) {

    }
    
    func didUpdateAlarm(with id: ObjectIdentifier) {
        
    }
    
    func didAddItem() {
    }

    func didUpdateItem(with id: ObjectIdentifier) {
    }
}

extension TableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.alarmsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(AlarmTableViewCell.self)", for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell()
        }
        let alarm = interactor.getAlarmAt(index: indexPath.row)
        cell.setup(with: alarm, observer: self)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AlarmTableViewCell else {
            return
        }
        interactor.didTapOpenAlarm(id: cell.id)
    }
}

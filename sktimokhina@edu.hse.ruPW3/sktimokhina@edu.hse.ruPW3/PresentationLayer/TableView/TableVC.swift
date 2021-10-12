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

    lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                               style: .done,
                               target: self,
                               action: #selector(didTapAddButton))
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: "\(AlarmTableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = true
        tableView.delaysContentTouches = true
        tableView.canCancelContentTouches = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
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
        view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        createAlarmHeader(addButton, "Table")
        interactor.load()
    }

    @objc func didTapAddButton() {
        interactor.didTapNewAlarm()
    }

    func setAlarms() {
        tableView.reloadData()
    }

    func showError() {
        
    }
}

extension TableVC: IAlarmUpdaterObserver {
    func didToggleIsOn(id: ObjectIdentifier, isOn: Bool) {
        interactor.update(id: id, isOn: isOn)
    }

    func didUpdateItem(with id: ObjectIdentifier) {
        guard let cell = tableView.visibleCells.first(where: {$0 is AlarmTableViewCell && ($0 as? AlarmTableViewCell)?.id == id}),
              let index = tableView.indexPath(for: cell) else {
            return
        }
        tableView.performBatchUpdates({
            tableView.reloadRows(at: [index], with: .none)
        })
    }

    func didAddItem() {
        interactor.prefetch { [weak self] in
            guard let self = self else { return }
            self.tableView.performBatchUpdates({
                let index = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
                self.tableView.reloadRows(at: [index], with: .none)
            })
        }
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

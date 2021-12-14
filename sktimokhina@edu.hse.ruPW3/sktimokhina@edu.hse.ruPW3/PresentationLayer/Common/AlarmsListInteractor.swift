//
//  AlarmsListInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import Foundation

import Foundation

protocol IAlarmsListInteractor {
    func didTapNewAlarm()
    func load()

    var alarmsCount: Int { get }
    func getAlarmAt(index: Int) -> Alarm?
    func update(id: ObjectIdentifier, isOn: Bool)
    func getAlarm(with id: ObjectIdentifier) -> Alarm?
    func didTapOpenAlarm(id: ObjectIdentifier)
    func prefetch(completion: @escaping () -> ())
    func delete(id: ObjectIdentifier, completion: @escaping () -> ())
}

final class AlarmsListInteractor: IAlarmsListInteractor {
    let presenter: IAlarmsListPresenter
    let worker: ICoreDataWorker
    private var alarms: [Alarm]?

    var alarmsCount: Int {
        return alarms?.count ?? 0
    }

    init(presenter: IAlarmsListPresenter, worker: ICoreDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func didTapNewAlarm() {
        presenter.shouldShowNewAlarm(with: worker)
    }

    func load() {
        do {
            self.alarms = try worker.loadAll()
            presenter.setAlarms()
        } catch {
            presenter.showError()
        }
    }

    func prefetch(completion: @escaping () -> ()) {
        do {
            self.alarms = try worker.loadAll()
            completion()
        } catch {
            presenter.showError()
        }
    }

    func getAlarmAt(index: Int) -> Alarm? {
        return alarms?.count ?? 0 > index ? alarms![index] : nil
    }

    func update(id: ObjectIdentifier, isOn: Bool) {
        guard let alarm = alarms?.first(where: {$0.id == id}) else { return }
        do {
            try worker.update(alarm: alarm, isOn: isOn)
            presenter.didUpdateAlarm(with: id)
        } catch {
            presenter.showError()
        }
    }

    func delete(id: ObjectIdentifier, completion: @escaping () -> ()) {
        guard let alarm = alarms?.first(where: {$0.id == id}) else { return }
        do {
            try worker.deleteItem(alarm: alarm)
            alarms?.removeAll(where: {$0.id == id})
            completion()
        } catch {
            presenter.showError()
        }
    }

    func getAlarm(with id: ObjectIdentifier) -> Alarm? {
        return alarms?.first(where: {$0.id == id})
    }

    func didTapOpenAlarm(id: ObjectIdentifier) {
        guard let alarm = alarms?.first(where: {$0.id == id}) else {
            return
        }
        presenter.shouldShowNewAlarm(with: worker, alarm: alarm)
    }
}

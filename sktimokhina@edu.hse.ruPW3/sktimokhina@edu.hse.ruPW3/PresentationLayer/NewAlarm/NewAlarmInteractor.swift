//
//  NewAlarmInteractor.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import Foundation

protocol INewAlarmInteractor {
    func didTapSaveButton(time: Date, descriptionText: String, isOn: Bool)
    func updateIfNeeded()
    func didTapDeleteButton()
    var shouldShowDeleteButton: Bool { get }
}

final class NewAlarmInteractor: INewAlarmInteractor {
    let presenter: INewAlarmPresenter
    let worker: ICoreDataWorker
    let alarm: Alarm?
    weak var observer: IAlarmUpdaterObserver?

    var shouldShowDeleteButton: Bool {
        alarm != nil
    }

    init(presenter: INewAlarmPresenter, worker: ICoreDataWorker, alarm: Alarm?, observer: IAlarmUpdaterObserver?) {
        self.presenter = presenter
        self.worker = worker
        self.alarm = alarm
        self.observer = observer
    }

    func didTapSaveButton(time: Date, descriptionText: String, isOn: Bool) {
        do {
            if (alarm != nil) {
                try worker.update(alarm: alarm!, time: time, descriptionText: descriptionText, isOn: isOn)
                observer?.didUpdateItem(with: alarm!.id)
            } else {
                try worker.didTapSaveButton(time: time, descriptionText: descriptionText, isOn: isOn)
                observer?.didAddItem()
            }
            presenter.shouldClose()
        } catch {
            presenter.shouldShowError()
        }
    }

    func didTapDeleteButton() {
        do {
            if (alarm != nil) {
                try worker.deleteItem(alarm: alarm!)
                observer?.didDeleteItem()
                presenter.shouldClose()
            }
        } catch {
            presenter.shouldShowError()
        }
    }

    func updateIfNeeded() {
        guard let alarm = alarm else { return }
        presenter.update(description: alarm.descriptionText ?? "", time: alarm.time, isOn: alarm.on)
    }
}

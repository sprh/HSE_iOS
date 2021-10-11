//
//  AlarmsListVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

final class CollectionVC: UIViewController, IAlarmsListVC {
    let interactor: IAlarmsListInteractor
    let router: IAlarmsListRouter

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width - 32, height: 10)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(AlarmCell.self, forCellWithReuseIdentifier: "\(AlarmCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.contentInsetAdjustmentBehavior = .always
        return collectionView
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
        interactor.load()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                        style: .done,
                                        target: self,
                                        action: #selector(didTapAddButton))
        createAlarmHeader(addButton, "Collection")
    }

    @objc
    func didTapAddButton() {
        interactor.didTapNewAlarm()
    }

    func setAlarms() {
        collectionView.reloadData()
    }

    func showError() {

    }
}

extension CollectionVC: IAlarmUpdaterObserver {
    func didAddItem() {
        interactor.prefetch { [weak self] in
            guard let self = self else { return }
            self.collectionView.performBatchUpdates({
                let index = IndexPath(row: self.collectionView.numberOfItems(inSection: 0), section: 0)
                self.collectionView.reloadItems(at: [index])
            })
        }
    }

    func didUpdateItem(with id: ObjectIdentifier) {
        guard let cell = collectionView.visibleCells.first(where: {$0 is AlarmCell && ($0 as? AlarmCell)?.id == id}),
              let index = collectionView.indexPath(for: cell) else {
            return
        }
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: [index])
        })
    }

    func didToggleIsOn(id: ObjectIdentifier, isOn: Bool) {
        interactor.update(id: id, isOn: isOn)
    }

}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.alarmsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AlarmCell.self)", for: indexPath) as? AlarmCell else {
            return UICollectionViewCell()
        }
        let alarm = interactor.getAlarmAt(index: indexPath.row)
        cell.setup(with: alarm, observer: self)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AlarmCell else {
            return
        }
        interactor.didTapOpenAlarm(id: cell.id)
    }
}

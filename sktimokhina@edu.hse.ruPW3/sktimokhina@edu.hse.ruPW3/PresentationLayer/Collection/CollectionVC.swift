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

    lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                               style: .done,
                               target: self,
                               action: #selector(didTapAddButton))
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width - 32, height: 50)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(AlarmCollectionViewCell.self, forCellWithReuseIdentifier: "\(AlarmCollectionViewCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
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
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAlarmHeader(addButton, "Collection")
        interactor.load()
    }

    @objc
    func didTapAddButton() {
        interactor.didTapNewAlarm()
    }

    func setAlarms() {
        collectionView.reloadData()
    }

    func showError() {
        router.showError()
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
        guard let cell = collectionView.visibleCells.first(where: {$0 is AlarmCollectionViewCell && ($0 as? AlarmCollectionViewCell)?.id == id}),
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AlarmCollectionViewCell.self)", for: indexPath) as? AlarmCollectionViewCell else {
            return UICollectionViewCell()
        }
        let alarm = interactor.getAlarmAt(index: indexPath.row)
        cell.setup(with: alarm, observer: self)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AlarmCollectionViewCell else {
            return
        }
        interactor.didTapOpenAlarm(id: cell.id)
    }
}

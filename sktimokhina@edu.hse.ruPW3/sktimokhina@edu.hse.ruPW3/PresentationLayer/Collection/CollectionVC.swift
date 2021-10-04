//
//  CollectionVC.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 03.10.2021.
//

import UIKit

protocol ICollectionVC: UIViewController {
}

final class CollectionVC: UIViewController, ICollectionVC {
    private let interactor: ICollectionInteractor

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = view.frame.width - 32
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(ClockCell.self, forCellWithReuseIdentifier: "\(ClockCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()

    init(interactor: ICollectionInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        let addButton = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: #selector(didTapAddButton))
        createAlarmHeader(addButton, "Collection")
    }

    @objc
    func didTapAddButton() {

    }
}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ClockCell.self)", for: indexPath) as? ClockCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

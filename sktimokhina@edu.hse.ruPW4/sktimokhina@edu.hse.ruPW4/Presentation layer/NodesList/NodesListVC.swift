//
//  NodesListVC.swift
//  sktimokhina@edu.hse.ruPW4
//
//  Created by Софья Тимохина on 19.10.2021.
//

import UIKit

protocol INodesListVC: UIViewController {
}

final class NodesListVC: UIViewController, INodesListVC {
    private let interactor: INodesListInteractor
    private let router: INodesListRouter

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: view.safeAreaInsets.bottom, right: 16)
        collectionView.alwaysBounceVertical = true
        collectionView.register(NodeCell.self, forCellWithReuseIdentifier: "\(NodeCell.self)")
        return collectionView
    }()

    init(interactor: INodesListInteractor, router: INodesListRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Nodes"
        setup()
    }

    func setup() {
        view.addSubview(collectionView)
    }
}


extension NodesListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(NodeCell.self)", for: indexPath) as? NodeCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

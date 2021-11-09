//
//  ArticlesListVC.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import UIKit

protocol IArticlesListVC: UIViewController {

}

final class ArticlesListVC: UIViewController, IArticlesListVC {
    private let interactor: IArticlesListInteractor
    private let router: IArticlesListRouter

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = true
        tableView.delaysContentTouches = true
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "\(ArticleTableViewCell.self)")
        let frame = view.frame
        tableView.frame = CGRect(x: 16,
                                 y: 0,
                                 width: view.frame.width - 32,
                                 height: view.frame.height - 16)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    init(interator: IArticlesListInteractor, router: IArticlesListRouter) {
        self.interactor = interator
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setup()
        interactor.load()
    }

    private func setup() {
        view.addSubview(tableView)
    }
}

extension ArticlesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.articlesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ArticleTableViewCell.self)",
                                                       for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.setup()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

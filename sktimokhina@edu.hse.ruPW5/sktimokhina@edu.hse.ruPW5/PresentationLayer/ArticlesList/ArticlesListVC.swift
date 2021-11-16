//
//  ArticlesListVC.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 08.11.2021.
//

import UIKit

protocol IArticlesListVC: UIViewController {
    func updateArticlesList()
    func updateCell(at index: Int)
    func loadArticles()
    func showError(message: String)
}

final class ArticlesListVC: UIViewController, IArticlesListVC {
    private let interactor: IArticlesListInteractor
    private let router: IArticlesListRouter

    let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
    lazy var loadingIndicator: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.customView = spinner
        button.isEnabled = false
        return button
    }()
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
                                 height: view.frame.height)
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
        setup()
        loadArticles()
    }

    private func setup() {
        view.backgroundColor = .background
        navigationItem.rightBarButtonItem = loadingIndicator
        spinner.startAnimating()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .background
        title = "Articles"
        view.addSubview(tableView)
    }

    func updateArticlesList() {
        tableView.performBatchUpdates {
            tableView.insertSections(IndexSet(tableView.numberOfSections..<interactor.articlesCount), with: .automatic)
        }
        spinner.stopAnimating()
    }

    func updateCell(at index: Int) {
        tableView.performBatchUpdates {
            tableView.reloadSections([index], with: .automatic)
        }
    }

    func loadArticles() {
        interactor.load()
    }

    func showError(message: String) {
        router.showError(message: message)
    }
}

extension ArticlesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.articlesCount
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = interactor.getArticle(at: indexPath.section) else {
            return
        }
        router.showArticleWebView(url: article.url)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ArticleTableViewCell.self)",
                                                       for: indexPath) as? ArticleTableViewCell,
              let article = interactor.getArticle(at: indexPath.section) else {
                  return UITableViewCell()
              }
        var image: UIImage = UIImage.articlePlaceholder
        var shouldShowShimmer: Bool = false
        if let imageUrl = article.imageUrl {
            let loadedImage = interactor.getImage(for: imageUrl, at: indexPath.section)
            image = loadedImage ?? UIImage()
            shouldShowShimmer = loadedImage == nil
        }
        cell.setup(articleTitle: article.title,
               articleDescription: article.articleDescription,
               articleImage: image)
        if (shouldShowShimmer) {
            cell.showShimmer()
        } else {
            cell.hideShimmer()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section >= tableView.numberOfSections - 3 &&
            interactor.hasNext {
            spinner.startAnimating()
            interactor.load()
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !(tableView.cellForRow(at: indexPath) is ArticleTableViewCell) { return nil}
        let shareAction = UIContextualAction(style: .normal, title: "",
        handler: {[weak self] (_: UIContextualAction, _: UIView, success: (Bool) -> Void) in
            guard let url = self?.interactor.getArticle(at: indexPath.section)?.url,
                  let urlToShare = URL(string: url) else {
                      return
                  }
            let title = "Share it!"
            let activityViewController = UIActivityViewController(
                activityItems: [title, urlToShare],
                applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self?.view
            self?.present(activityViewController, animated: true)
        })
        shareAction.image = .share
        shareAction.backgroundColor = .background
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
}
//
//  MoviesVC.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import UIKit

protocol IMoviesVC: UIViewController {
    func updateTableView()
    func showError(_ error: String)
}

final class MoviesVC: UIViewController, IMoviesVC {
    private let interactor: IMoviesInteractor
    private let router: IMoviesRouter

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieCell.self, forCellReuseIdentifier: "\(MovieCell.self)")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(interactor: IMoviesInteractor, router: IMoviesRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.loadMovies()
    }

    private func setup() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8220604658, blue: 0.8168862462, alpha: 1)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func updateTableView() {
        tableView.reloadData()
    }

    func showError(_ error: String) {
        router.showError(error)
    }
}

extension MoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieCell.self)", for: indexPath) as? MovieCell,
              let movie = interactor.getMovie(at: indexPath.row) else { return UITableViewCell() }
        cell.setup(movie: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.moviesCount
    }
}

//
//  MoviesInteractor.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation

protocol IMoviesInteractor {
    func loadMovies()
    func getMovie(at index: Int) -> Movie?
    var moviesCount: Int { get }
}

final class MoviesInteractor: IMoviesInteractor {
    private let presenter: IMoviesPresenter
    private let service = MoviesService.shared
    private let storage = MoviesStorage.shared

    init(presenter: IMoviesPresenter) {
        self.presenter = presenter
    }

    var moviesCount: Int {
        storage.moviesCount
    }

    func loadMovies() {
        service.loadMovies { [weak self] result in
            switch (result) {
            case let .success(movies):
                DispatchQueue.main.async {
                    self?.storage.addMovies(movies)
                    self?.presenter.updateTableView()
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.presenter.showError(error.toString())
                }
            }
        }
    }

    func getMovie(at index: Int) -> Movie? {
        return storage.getMovie(at: index)
    }
}

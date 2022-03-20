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
    private let imagesService = ImagesService.shared

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
                    self?.loadImages(movies: movies)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.presenter.showError(error.toString())
                }
            }
        }
    }

    func loadImages(movies: [Movie]) {
        imagesService.loadImages(urls: movies.map({$0.posterPath})) { [weak self] images in
            var finalMovies: [Movie] = []
            print(images)
            for i in 0..<movies.count {
                finalMovies.append(Movie(title: movies[i].title,
                                         posterPath: movies[i].posterPath,
                                         poster: images.count > i ? images[i] : nil))
            }
            DispatchQueue.main.async {
                self?.storage.addMovies(finalMovies)
                self?.presenter.updateTableView()
            }
        }
    }

    func getMovie(at index: Int) -> Movie? {
        return storage.getMovie(at: index)
    }
}

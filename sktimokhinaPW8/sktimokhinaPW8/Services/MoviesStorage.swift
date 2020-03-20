//
//  MoviesStorage.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation

protocol IMoviesStorage {
    var moviesCount: Int { get }

    func addMovies(_ movies: [Movie])
    func getMovie(at index: Int) -> Movie?
}

class MoviesStorage: IMoviesStorage {
    private var movies: [Movie] = []
    private static var _shared: IMoviesStorage?

    static var shared: IMoviesStorage {
        guard let instance = MoviesStorage._shared else {
            MoviesStorage._shared = MoviesStorage()
            return MoviesStorage._shared!
        }
        return instance
    }

    var moviesCount: Int {
        movies.count
    }

    func addMovies(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }

    func getMovie(at index: Int) -> Movie? {
        return index >= moviesCount ? nil : movies[index]
    }
}

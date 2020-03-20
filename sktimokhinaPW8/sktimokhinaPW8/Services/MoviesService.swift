//
//  MoviesService.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation

protocol IMoviesService {
    func loadMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void)
}

class MoviesService: IMoviesService {
    private static var _shared: IMoviesService?

    static var shared: IMoviesService {
        guard let instance = MoviesService._shared else {
            MoviesService._shared = MoviesService()
            return MoviesService._shared!
        }
        return instance
    }

    let queue = DispatchQueue(label: "MoviesService", attributes: [.concurrent])
    let path: String = "https://api.themoviedb.org/3/discover/movie?api_key=7fc827acd9f3c9f8d0282e5b0ebe4187&language=ruRu"

    private var session: URLSession = {
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = 30.0
        return session
    }()

    private func createURL(path: String) -> URLRequest? {
        guard let url = URL(string: path) else {
            return nil
        }
        return URLRequest(url: url)
    }

    func createTask(completion: @escaping (Result<[Movie], NetworkError>) -> Void,
                    urlRequest: URLRequest) -> URLSessionDataTask {
        let task = self.session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.loadingError(error.localizedDescription)))
            } else if let data = data,
                      let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any],
                      let results = dataDictionary["results"] as? [[String: Any]],
                      let resultsJsonData = try? JSONSerialization.data(withJSONObject: results),
                      let movies = try? JSONDecoder().decode([Movie].self, from: resultsJsonData) {
                completion(.success(movies))
            } else if let response = response as? HTTPURLResponse {
                completion(.failure(.serviceError(response.statusCode)))
            } else {
                completion(.failure(.unknownError))
            }
        }
        return task
    }

    func loadMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let urlRequest = createURL(path: path) else { completion(.failure(NetworkError.incorrectUrl)); return }
        let task = createTask(completion: completion, urlRequest: urlRequest)
        queue.async {
            task.resume()
        }
    }
}

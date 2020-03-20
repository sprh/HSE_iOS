//
//  ImagesService.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation
import UIKit

protocol IImagesService {
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void)
}

class ImagesService: IImagesService {
    private static var _shared: IImagesService?

    static var shared: IImagesService {
        guard let instance = ImagesService._shared else {
            ImagesService._shared = ImagesService()
            return ImagesService._shared!
        }
        return instance
    }

    let queue = DispatchQueue(label: "ImagesService", attributes: [.concurrent])
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

    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {

    }

}

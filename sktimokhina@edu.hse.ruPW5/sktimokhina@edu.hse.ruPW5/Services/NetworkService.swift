//
//  NetworkService.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 09.11.2021.
//

import Foundation

protocol INetworkService {
    func load(completion: @escaping (Result<[Article], Error>) -> Void)

    var loading: Bool { get }
    var hasNext: Bool { get }
}

enum NetworkError: Error {
    case incorrectUrl
    case unknownError
    case incorrectData
}

final class NetworkService: INetworkService {
    private let queue = DispatchQueue(label: "NetworkQueue", attributes: [.concurrent])
    private let basePath: String = "https://newsapi.org/v2/everything?qInTitle=ios&"
    private let apiKey: String = "74db4d150c784f08a864330c81d209f3"

    private var page = 0
    private let pageSize = 14
    var loading: Bool = false
    var hasNext: Bool = true

    private var session: URLSession = {
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = 30.0
        return session
    }()

    func createUrlRequest(path: String) -> URLRequest? {
        guard let url = URL(string: path) else {
            return nil
        }
        return URLRequest(url: url)
    }

    func load(completion: @escaping (Result<[Article], Error>) -> Void) {
        if loading {
            return
        }

        loading = true
        guard let urlRequest = createUrlRequest(path: "\(basePath)&pageSize=\(pageSize)&page=\(page+1)&apiKey=\(apiKey)") else {
            completion(.failure(NetworkError.incorrectUrl))
            return
        }
        let task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.loading = false
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                      let articlesJson = json["articles"],
                      let articlesData = try? JSONSerialization.data(withJSONObject: articlesJson, options: .prettyPrinted),
                      let articles = try? JSONDecoder().decode([Article].self, from: articlesData) else {
                          DispatchQueue.main.async {
                              completion(.failure(NetworkError.incorrectData))
                          }
                          return
                      }
                self?.page += 1
                self?.hasNext = articles.count == self?.pageSize
                DispatchQueue.main.async {
                    completion(.success(articles))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        }
        queue.async {
            task.resume()
        }
    }
}

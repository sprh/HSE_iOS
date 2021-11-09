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
}

enum NetworkError: Error {
    case incorrectUrl
    case unknownError
}

final class NetworkService: INetworkService {
    private let queue = DispatchQueue(label: "NetworkQueue", attributes: [.concurrent])

    private let basePath: String = "https://newsapi.org/v2/top-headlines?language=ru"
    private let apiKey: String = "74db4d150c784f08a864330c81d209f3"

    private var page = 0

    var loading: Bool = false

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
        if (loading) {
            return
        }

        loading = true
        guard let urlRequest = createUrlRequest(path: "\(basePath)&pageSize=14&page=\(page+1)&apiKey=74db4d150c784f08a864330c81d209f3") else {
            completion(.failure(NetworkError.incorrectUrl))
            return
        }
        let task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.loading = false
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                } catch{ print("erroMsg") }
            } else {
                completion(.failure(NetworkError.unknownError))
            }
        }
        task.resume()
    }
}

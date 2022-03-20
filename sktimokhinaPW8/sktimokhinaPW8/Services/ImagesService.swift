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
    func loadImages(urls: [String], completion: @escaping ([UIImage?]) -> Void)
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

    let basePath: String = "https://image.tmdb.org/t/p/original/"

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

    func createTask(completion: @escaping (UIImage?) -> Void,
                    urlRequest: URLRequest) -> URLSessionDataTask {
        let task = self.session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        return task
    }

    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let urlRequest = createURL(path: "\(basePath)\(url)") else { completion(nil); return }
        let task = createTask(completion: completion, urlRequest: urlRequest)
        task.resume()
    }

    func loadImages(urls: [String], completion: @escaping ([UIImage?]) -> Void) {
        let group = DispatchGroup()
        var images: [UIImage?] = []

        for url in urls {
            group.enter()
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.loadImage(url: url) { image in
                    images.append(image)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            completion(images)
        }
    }
}

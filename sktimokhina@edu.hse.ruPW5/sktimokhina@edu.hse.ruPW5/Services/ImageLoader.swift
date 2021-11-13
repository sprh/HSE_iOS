//
//  ImageLoader.swift
//  sktimokhina@edu.hse.ruPW5
//
//  Created by Софья Тимохина on 10.11.2021.
//

import UIKit

protocol IImageLoader {
    func loadImage(path: String, completion: @escaping (UIImage?) -> Void)
    func getImage(path: String) -> UIImage?
}

final class ImageLoader: IImageLoader {
    let imageCache = NSCache<NSString, UIImage>()

    private let queue = DispatchQueue(label: "ImageLoader", attributes: [.concurrent])

    func loadImage(path: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: path) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let image = UIImage(data: data) else {
                      DispatchQueue.main.async {
                          completion(nil)
                      }
                      return
                  }
            self?.imageCache.setObject(image, forKey: NSString(string: path))
            DispatchQueue.main.async {
                completion(image)
            }

        }
        queue.async {
            task.resume()
        }
    }

    func getImage(path: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: path))
    }
}

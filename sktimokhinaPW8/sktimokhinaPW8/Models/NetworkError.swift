//
//  NetworkError.swift
//  sktimokhinaPW8
//
//  Created by Софья Тимохина on 20.03.2022.
//

import Foundation

enum NetworkError : Error {
    case incorrectUrl
    case serviceError(_ statusCode: Int)
    case loadingError(_ description: String)
    case unknownError

    func toString() -> String {
        switch (self) {
        case .incorrectUrl:
            return "Incorrect url"
        case let .serviceError(status):
            return "Service error \(status)"
        case let .loadingError(descr):
            return descr
        case .unknownError:
            return "Unknown error"
        }
    }
}

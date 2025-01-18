//
//  NetworkResponseHandler.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/5/2567 BE.
//

import Foundation
private enum Constants {
    static let statusCodeSuccess: Int = 200
}

protocol NetworkResponseHandlerInterface {
    func handler(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: (Result<Data, Error>) -> Void
    )
}
struct NetworkResponseHandler { }

extension NetworkResponseHandler: NetworkResponseHandlerInterface {
    func handler(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: (Result<Data, Error>) -> Void
    ) {
        if let error {
            completion(.failure(error))
        } else {
            if let response = response as? HTTPURLResponse, let data {
                let statusCode = response.statusCode
                if statusCode == Constants.statusCodeSuccess {
                    completion(.success(data))
                } else {
                    let genericError = NetworkGeneralError(data: data)
                    completion(.failure(genericError))
                }
            } else {
                let genericError = NetworkGeneralError()
                completion(.failure(genericError))
            }
        }
    }
}

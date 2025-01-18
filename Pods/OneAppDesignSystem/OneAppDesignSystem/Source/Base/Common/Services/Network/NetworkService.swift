//
//  NetworkService.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/5/2567 BE.
//

import Foundation
struct NetworkGeneralError: Error {
    var data: Data?
}

protocol NetworkServiceInterface {
    func request(
        _ request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}

struct NetworkService {
    private var networkSession: URLSession
    private var networkResponseHandler: NetworkResponseHandlerInterface

    init(
        networkSession: URLSession,
        networkResponseHandler: NetworkResponseHandlerInterface
    ) {
        self.networkSession = networkSession
        self.networkResponseHandler = networkResponseHandler
    }
}

extension NetworkService: NetworkServiceInterface {
    func request(
        _ request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        networkSession.dataTask(with: request) { data, response, error in
            networkResponseHandler.handler(
                data: data,
                response: response,
                error: error,
                completion: completion
            )
        }
        .resume()
    }
}

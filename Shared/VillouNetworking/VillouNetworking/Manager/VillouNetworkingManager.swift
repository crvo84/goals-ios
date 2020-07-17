//
//  VillouNetworkingManager.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

protocol URLRequestHandler {
    func handle(request: URLRequest) -> Single<(Data?, URLResponse?, Error?)>
}

public class VillouNetworkingManager: NetworkingManager {

    private let urlRequestHandler: URLRequestHandler

    init(urlRequestHandler: URLRequestHandler) {
        self.urlRequestHandler = urlRequestHandler
    }

    public convenience init() {
        self.init(urlRequestHandler: URLSession.shared)
    }

    public func execute(request: ApiRequest) -> Single<Data?> {
        do {
            let urlRequest = try request.asURLRequest()
            return handle(urlRequest: urlRequest)
        } catch {
            return .error(error)
        }
    }

    private func handle(urlRequest: URLRequest) -> Single<Data?> {
        return urlRequestHandler.handle(request: urlRequest)
            .map { data, urlResponse, error -> Data? in
                guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else {
                    throw ApiError.invalidResponse(error)
                }

                guard 200..<300 ~= statusCode else {
                    throw ApiError.response(error, statusCode: statusCode, data: data)
                }

                return data
            }
    }

}

extension URLSession: URLRequestHandler {

    func handle(request: URLRequest) -> Single<(Data?, URLResponse?, Error?)> {
        return .create { [weak self] single in
            self?.dataTask(with: request) { (data, response, error) in
                single(.success((data, response, error)))
            }.resume()

            return Disposables.create()
        }
    }
}

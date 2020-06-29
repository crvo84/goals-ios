//
//  NetworkingManager.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

public protocol NetworkingManager {
    func execute(request: ApiRequest) -> Single<Data?>
    func execute<T: Decodable>(request: ApiRequest, decodeType: T.Type) -> Single<T>
    func execute<T: Decodable>(request: ApiRequest, decodeType: T.Type) -> Single<T?>
}

// MARK: Decoding
public extension NetworkingManager {

    func execute<T: Decodable>(request: ApiRequest, decodeType: T.Type) -> Single<T> {
        return execute(request: request).map {
            try Self.decode(decodeType, from: $0)
        }
    }

    func execute<T: Decodable>(request: ApiRequest, decodeType: T.Type) -> Single<T?> {
        return execute(request: request).map {
            try? Self.decode(decodeType, from: $0)
        }
    }

    private static func decode<T: Decodable>(_ type: T.Type, from data: Data?) throws -> T {
        guard let data = data else {
            throw ApiError.decoding(nil)
        }

        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw ApiError.decoding(error)
        }
    }

}

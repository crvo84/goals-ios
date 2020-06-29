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
}

// MARK: Decoding
public extension NetworkingManager {

    func execute<T: Decodable>(request: ApiRequest, decodeType: T.Type) -> Single<T> {
        return execute(request: request).map {
            guard let data = $0 else {
                throw ApiError.decoding(nil)
            }

            do {
                return try JSONDecoder().decode(decodeType, from: data)
            } catch {
                throw ApiError.decoding(error)
            }
        }
    }
}

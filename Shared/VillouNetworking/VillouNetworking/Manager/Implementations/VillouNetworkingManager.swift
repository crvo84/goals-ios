//
//  VillouNetworkingManager.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

class VillouNetworkingManager: NetworkingManager {

    func execute(request: ApiRequest) -> Single<Data?> {
        do {
            return executeDataTask(with: try request.asURLRequest())
        } catch {
            return .error(error)
        }
    }

    private func executeDataTask(with request: URLRequest) -> Single<Data?> {
        return Single<Data?>.create { single in

            URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else {
                    single(.error(ApiError.invalidResponse(error)))
                    return
                }

                guard 200..<300 ~= statusCode else {
                    let responseError = ApiError.response(error, statusCode: statusCode, data: data)
                    single(.error(responseError))
                    return
                }

                single(.success(data))

                // TODO: print response to console for debugging
            }

            return Disposables.create()
        }
    }

}

//
//  GoalsRemoteApi.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

class GoalsRemoteApi: RemoteApi {

    func call(endpoint: ApiEndpoint) -> Single<Data?> {
        do {
            return execute(request: try endpoint.asURLRequest())
        } catch {
            return .error(error)
        }
    }

    private func execute(request: URLRequest) -> Single<Data?> {
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

                // TODO: for debugging
                if let data = data {
                    print(String(data: data, encoding: .utf8) ?? "")
                } else {
                    print("Response without body data")
                }
                // ------------
            }

            return Disposables.create()
        }
    }


}

//
//  MockNetworkingManager.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

public class MockNetworkingManager: NetworkingManager {

    private let waitDuration: TimeInterval

    public init(waitDuration: TimeInterval = 1.5) {
        self.waitDuration = waitDuration
    }

    public func execute(request: ApiRequest) -> Single<Data?> {
        let waitDuration = self.waitDuration
        return Single<Data?>.create { single in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + waitDuration) {
                
                guard let (statusCode, data, error) = request.mockResponse else {
                    single(.error(ApiError.invalidRequest(nil)))
                    return
                }

                guard 200..<300 ~= statusCode else {
                    single(.error(ApiError.response(error, statusCode: statusCode, data: data)))
                    return
                }

                single(.success(data))
            }

            return Disposables.create()
        }
    }
}

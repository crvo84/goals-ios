//
//  MockNetworkingManager.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

class MockNetworkingManager: NetworkingManager {

    func callApi(endpoint: ApiEndpoint) -> Single<Data?> {
        let waitDuration = 1.5

        return Observable.create { observer in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + waitDuration) {
                observer.onNext(endpoint.mockResponseData)
                observer.onCompleted()
            }
            return Disposables.create()
        }
        .asSingle()
    }
}

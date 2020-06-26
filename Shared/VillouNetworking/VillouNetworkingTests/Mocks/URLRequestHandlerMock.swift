//
//  URLRequestHandlerMock.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 25/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift
@testable import VillouNetworking

class URLRequestHandlerMock: URLRequestHandler {

    struct ExpectedResults {
        var data: Data?
        var urlResponse: URLResponse?
        var error: Error?
    }

    struct DidCalls {
        var handleRequest = false
    }

    struct ParametersPassed {
        var handleRequest: URLRequest?
    }

    var didCall = DidCalls()
    var expectedResult = ExpectedResults()
    var parameterPassed = ParametersPassed()

    func handle(request: URLRequest) -> Single<(Data?, URLResponse?, Error?)> {
        didCall.handleRequest = true
        parameterPassed.handleRequest = request
        let expected = expectedResult

        return .create { single in
            single(.success((expected.data, expected.urlResponse, expected.error)))

            return Disposables.create()
        }
    }

}

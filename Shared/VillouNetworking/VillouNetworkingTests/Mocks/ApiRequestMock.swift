//
//  ApiRequestMock.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 27/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
@testable import VillouNetworking

struct ApiRequestMock: ApiRequest {
    var scheme: URIScheme = .https

    var method: HTTPMethod = .get

    var headers: HTTPHeaders?

    var host: String = "villou.com"

    var basePath: String?

    var path: String = "/"

    var body: Data?

    var contentType: HTTPContentType?

    var mockResponse: HTTPMockResponse?

    struct ExpectedResults {
        var asURLRequest: Result<URLRequest, ApiError> = .failure(.unknown)
    }

    var expectedResult = ExpectedResults()

    func asURLRequest() throws -> URLRequest {
        switch expectedResult.asURLRequest {
        case .success(let req):
            return req
        case .failure(let error):
            throw error
        }
    }
}

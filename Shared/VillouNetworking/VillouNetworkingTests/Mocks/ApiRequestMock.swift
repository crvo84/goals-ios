//
//  ApiRequestMock.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 25/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
@testable import VillouNetworking

struct ApiRequestMock {
    var scheme: URIScheme = .https
    var method: HTTPMethod = .get
    var headers: HTTPHeaders?
    var host: String = "villou.com"
    var basePath: String? = "/api"
    var path: String = "/"
    var body: Data?
    var contentType: HTTPContentType?
    var mockResponse: HTTPMockResponse?


}

extension ApiRequestMock: ApiRequest {
    
}

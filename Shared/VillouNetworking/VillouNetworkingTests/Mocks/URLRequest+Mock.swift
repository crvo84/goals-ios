//
//  URLRequest+Mock.swift
//  VillouNetworkingTests
//
//  Created by Carlos Villanueva Ousset on 27/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

extension URL {
    static var mock: URL { URL(string: "https://www.google.com")! }
}

extension URLRequest {
    
    static var mock: URLRequest { .mock() }

    static func mock(url: URL = .mock, cachePolicy: CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0) -> URLRequest {
        URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    }
}

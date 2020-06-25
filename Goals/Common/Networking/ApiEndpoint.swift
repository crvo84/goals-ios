//
//  ApiEndpoint.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case invalidRequest(Error?)
    case invalidResponse(Error?)
    case response(Error?, statusCode: Int, data: Data?)
    case decoding(Error?)
}

enum URIScheme: String {
    case https = "https"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPContentType: String {
    case json = "application/json"
}

typealias HTTPHeaders = [String: String]

protocol ApiEndpoint {

    var scheme: URIScheme { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var host: String { get }
    var path: String { get }
    var body: Data? { get }
    var contentType: HTTPContentType? { get }
    var mockResponseData: Data? { get }

    func asURLRequest() throws -> URLRequest
}

extension ApiEndpoint {

    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        // url
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path

        guard let url = components.url else {
            throw ApiError.invalidRequest(nil)
        }

        var req = URLRequest(url: url)

        // method
        req.httpMethod = method.rawValue

        // headers
        headers?.forEach {
            req.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        // body
        req.httpBody = body
        if let contentTypeStr = contentType?.rawValue {
            req.setValue(contentTypeStr, forHTTPHeaderField: "Content-Type")
        }

        return req
    }
}

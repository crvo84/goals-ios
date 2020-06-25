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

protocol ApiEndpoint {

    typealias Params = [String: Any]
    typealias Headers = [String: String]

    var scheme: URIScheme { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: Headers? { get }
    var urlParams: Params? { get }
    var bodyParams: Params? { get }
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

        // url params
        components.queryItems = urlParams?.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }

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
        if let bodyParams = bodyParams {
            do {
                req.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
                if let contentTypeStr = contentType?.rawValue {
                    req.setValue(contentTypeStr, forHTTPHeaderField: "Content-Type")
                }
            } catch {
                throw ApiError.invalidRequest(error)
            }
        }

        return req
    }
}

//
//  HTTPMockResponse.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 22/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public struct HTTPMockResponse {
    let statusCode: Int
    let data: Data?
    let error: Error?
}

public extension HTTPMockResponse {

    static func success(jsonFilename: String, statusCode: Int = 200) -> HTTPMockResponse {
        guard let path = Bundle.main.path(forResource: jsonFilename, ofType: "json") else {
            fatalError("HTTPMockResponse.success json file not found: \(jsonFilename).json")
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            fatalError("HTTPMockResponse.success error reading json file: \(jsonFilename).json")
        }

        return HTTPMockResponse(statusCode: statusCode, data: data, error: nil)
    }

    static func failure(statusCode: Int, error: Error) -> HTTPMockResponse {
        return HTTPMockResponse(statusCode: statusCode, data: nil, error: error)
    }
}

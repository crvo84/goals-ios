//
//  ApiError.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 25/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public enum ApiError: Error {
    case invalidRequest(Error?)
    case invalidResponse(Error?)
    case response(Error?, statusCode: Int, data: Data?)
    case decoding(Error?)
    case unknown
}

public extension Error {
    var asApiError: ApiError? { self as? ApiError }
}

public extension ApiError {
    var isInvalidRequest: Bool {
        guard case .invalidRequest = self else { return false }
        return true
    }

    var isInvalidResponse: Bool {
        guard case .invalidResponse = self else { return false }
        return true
    }

    var isResponse: Bool {
        guard case .response = self else { return false }
        return true
    }

    var isDecoding: Bool {
        guard case .decoding = self else { return false }
        return true
    }

    var isUnknown: Bool {
        guard case .unknown = self else { return false }
        return true
    }
}

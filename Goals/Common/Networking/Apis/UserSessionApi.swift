//
//  UserSessionApi.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import VillouNetworking

enum UserSessionApi {
    case signIn(body: Data)
    case signUp(body: Data)
}

extension UserSessionApi: ApiRequest {

    var method: HTTPMethod {
        switch self {
        case .signIn, .signUp:
            return .post
        }
    }

    var path: String {
        switch self {
        case .signIn:
            return "/users/login"
        case .signUp:
            return "/users"
        }
    }

    var body: Data? {
        switch self {
        case let .signIn(data), let .signUp(data):
            return data
        }
    }

    var mockResponse: HTTPMockResponse? {
        return nil
    }

    // MARK: Constant values

    var host: String { Constants.GoalsApi.host }

    var basePath: String { Constants.GoalsApi.basePath }

    var scheme: URIScheme { return .https }

    var headers: HTTPHeaders? { nil }

    var contentType: HTTPContentType? { .json }
}

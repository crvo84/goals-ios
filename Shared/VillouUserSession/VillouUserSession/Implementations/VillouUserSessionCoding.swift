//
//  VillouUserSessionCoding.swift
//  VillouUserSession
//
//  Created by Carlos Villanueva Ousset on 14/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public struct VillouUserSessionCoding<T: UserSession>: UserSessionCoding {

    public typealias UserSessionType = T

    public enum CodingType { case json, propertyList }

    private let codingType: CodingType

    public init(codingType: CodingType = .json) {
        self.codingType = codingType
    }

    public func encode(userSession: T) -> Data {
        var data: Data?
        switch codingType {
        case .json:
            data = try? JSONEncoder().encode(userSession)
        case .propertyList:
            data = try? PropertyListEncoder().encode(userSession)
        }
        guard let validData = data else { fatalError() }

        return validData
    }

    public func decode(data: Data) -> T {
        var session: T?
        switch codingType {
        case .json:
            session = try? JSONDecoder().decode(T.self, from: data)
        case .propertyList:
            session = try? PropertyListDecoder().decode(T.self, from: data)
        }
        guard let validSession = session else { fatalError() }

        return validSession
    }
}

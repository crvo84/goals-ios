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
        switch codingType {
        case .json:
            return try! JSONEncoder().encode(userSession)
        case .propertyList:
            return try! PropertyListEncoder().encode(userSession)
        }

    }

    public func decode(data: Data) -> T {
        switch codingType {
        case .json:
            return try! JSONDecoder().decode(T.self, from: data)
        case .propertyList:
            return try! PropertyListDecoder().decode(T.self, from: data)
        }
    }
}

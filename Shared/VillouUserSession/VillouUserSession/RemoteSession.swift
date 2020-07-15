//
//  RemoteSession.swift
//  VillouUserSession
//
//  Created by Carlos Villanueva Ousset on 15/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public protocol RemoteSession: Codable, Equatable {
    var token: String { get }
}

public extension RemoteSession {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.token == rhs.token
    }
}

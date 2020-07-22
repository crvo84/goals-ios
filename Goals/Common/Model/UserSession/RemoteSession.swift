//
//  RemoteSession.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 14/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct RemoteSession: Codable, Equatable {
    let token: String
}

extension RemoteSession {
    static func ==(lhs: RemoteSession, rhs: RemoteSession) -> Bool {
        return lhs.token == rhs.token
    }
}

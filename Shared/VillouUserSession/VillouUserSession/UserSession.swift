//
//  UserSession.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public protocol UserSession: class, Codable {
    var profile: UserProfile { get }
    var remoteSession: RemoteSession { get }
}

public extension UserSession {
    static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
        return lhs.remoteSession == rhs.remoteSession &&
                lhs.profile == rhs.profile
    }
}

//
//  UserSession.swift
//  VillouUserSession
//
//  Created by Carlos Villanueva Ousset on 15/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public protocol UserSession: Codable, Equatable {

    associatedtype UserProfileType: UserProfile
    associatedtype RemoteSessionType: RemoteSession

    var userProfile: UserProfileType { get }
    var remoteSession: RemoteSessionType { get }
}

public extension UserSession {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.remoteSession == rhs.remoteSession && lhs.userProfile == rhs.userProfile
    }
}

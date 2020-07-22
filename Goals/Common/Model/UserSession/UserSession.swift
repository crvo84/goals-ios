//
//  UserSession.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 14/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

class UserSession: Codable, Equatable {
    let userProfile: UserProfile
    let remoteSession: RemoteSession

    init(userProfile: UserProfile, remoteSession: RemoteSession) {
        self.userProfile = userProfile
        self.remoteSession = remoteSession
    }
}

extension UserSession {
    static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
        return lhs.remoteSession == rhs.remoteSession && lhs.userProfile == rhs.userProfile
    }
}

//
//  UserSession.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

class UserSession: DataModel {

    let profile: UserProfile
    let remoteSession: RemoteSession

    init(profile: UserProfile, remoteSession: RemoteSession) {
        self.profile = profile
        self.remoteSession = remoteSession
    }
}

extension UserSession {
    static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
        return lhs.remoteSession == rhs.remoteSession &&
                lhs.profile == rhs.profile
    }
}

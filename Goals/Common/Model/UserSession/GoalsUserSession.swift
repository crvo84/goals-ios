//
//  GoalsUserSession.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 14/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import VillouUserSession

class GoalsUserSession: UserSession {
    let userProfile: GoalsUserProfile
    let remoteSession: GoalsRemoteSession

    init(userProfile: GoalsUserProfile, remoteSession: GoalsRemoteSession) {
        self.userProfile = userProfile
        self.remoteSession = remoteSession
    }
}

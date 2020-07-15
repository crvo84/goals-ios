//
//  GoalsRemoteSession.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 14/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import VillouUserSession


struct GoalsRemoteSession: RemoteSession {
    let token: String
}

extension RemoteSession: Equatable {
    static func ==(lhs: RemoteSession, rhs: RemoteSession) -> Bool {
        return lhs.token == rhs.token
    }
}

extension GoalsRemoteSession: DataModel { }

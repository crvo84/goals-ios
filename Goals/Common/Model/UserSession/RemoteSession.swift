//
//  SessionToken.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct RemoteSession: DataModel {
    let token: String
}

extension RemoteSession: Equatable {
    static func ==(lhs: RemoteSession, rhs: RemoteSession) -> Bool {
        return lhs.token == rhs.token
    }
}

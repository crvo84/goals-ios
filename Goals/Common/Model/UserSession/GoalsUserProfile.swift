//
//  GoalsUserProfile.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import VillouUserSession

struct GoalsUserProfile: UserProfile {
    let email: String
    let fullName: String
    let nickName: String
    let avatar: URL?
}

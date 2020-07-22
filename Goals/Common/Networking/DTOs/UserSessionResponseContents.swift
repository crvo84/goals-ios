//
//  UserSessionResponseContents.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 21/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct SignUpResponseContent: Decodable {
    let profile: UserProfile
    let token: String
}

struct SignInResponseContent: Decodable {
    let profile: UserProfile
    let token: String
}

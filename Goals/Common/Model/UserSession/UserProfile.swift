//
//  UserProfile.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    let email: String
    let fullName: String
    let nickName: String
    let avatar: URL?
}

extension UserProfile: Equatable {}

//
//  UserProfile.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct UserProfile: Codable, Equatable {
    let email: String
    let firstName: String
    let lastName: String
    let avatar: URL?
}


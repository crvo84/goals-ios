//
//  UserProfile.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct UserProfile: DataModel, Equatable {
    let fullName: String
    let nickName: String
    let email: String
    let avatar: URL?
}

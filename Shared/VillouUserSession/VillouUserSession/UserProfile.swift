//
//  UserProfile.swift
//  VillouUserSession
//
//  Created by Carlos Villanueva Ousset on 15/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public protocol UserProfile: Codable, Equatable {
    var email: String { get }
}

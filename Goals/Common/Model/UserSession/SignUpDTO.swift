//
//  SignUpDTO.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct SignUpDTO: Codable {
    let email: String
    let fullName: String
    let nickName: String
    let password: String
}

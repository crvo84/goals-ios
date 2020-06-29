//
//  SignUpDTO.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct SignUpDTO: DataModel {
    let fullName: String
    let nickName: String
    let email: String
    let password: String
}

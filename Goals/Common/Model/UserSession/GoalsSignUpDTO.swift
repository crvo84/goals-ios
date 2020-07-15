//
//  GoalsSignUpDTO.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import VillouUserSession

struct GoalsSignUpDTO: SignUpDTO {
    let fullName: String
    let nickName: String
    let email: String
    let password: String
}

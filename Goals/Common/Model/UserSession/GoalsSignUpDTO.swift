//
//  GoalsSignUpDTO.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import VillouUserSession

struct GoalsSignUpDTO: SignUpDTO {
    let email: String
    let fullName: String
    let nickName: String
    let password: String
}

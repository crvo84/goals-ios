//
//  GoalsSignUpDTO.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import VillouUserSession

struct GoalsSignUpDTO: SignUpDTO {
    let firstName: String
    let lastName: String
    let password: String
    let email: String
    let gender: String?
    let country: String?
    let age: Int?
}

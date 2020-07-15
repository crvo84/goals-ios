//
//  GoalsSignInDTO.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import VillouUserSession

struct GoalsSignInDTO: SignInDTO {
    let email: String
    let password: String
}

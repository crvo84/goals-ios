//
//  UserSessionResponseContents.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 21/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

// MARK: - SignUp

struct SignUpResponseContent: Decodable {
    let profile: UserProfile
    let token: String
}

extension SignUpResponseContent {
    var userSession: UserSession {
        UserSession(userProfile: profile, remoteSession: RemoteSession(token: token))
    }
}

// MARK: - SignIn

struct SignInResponseContent: Decodable {
    let profile: UserProfile
    let token: String
}

extension SignInResponseContent {
    var userSession: UserSession {
        UserSession(userProfile: profile, remoteSession: RemoteSession(token: token))
    }
}

//
//  UserSessionStateResponder.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

protocol UserSessionStateResponder {
    func respondToSignedIn(with userSession: UserSession)
    func respondToNotSignedIn()
}

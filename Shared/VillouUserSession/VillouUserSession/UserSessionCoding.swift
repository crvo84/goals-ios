//
//  UserSessionCoding.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 28/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

protocol UserSessionCoding {
    func encode(userSession: UserSession) -> Data
    func decode(data: Data) -> UserSession
}

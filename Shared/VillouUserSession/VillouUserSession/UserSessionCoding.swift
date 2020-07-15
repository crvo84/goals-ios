//
//  UserSessionCoding.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 28/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public protocol UserSessionCoding {
    func encode<U: UserSession>(userSession: U) -> Data
    func decode<U: UserSession>(data: Data) -> U
}

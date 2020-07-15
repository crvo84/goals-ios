//
//  UserSessionCoding.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 28/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public protocol UserSessionCoding {
    associatedtype UserSessionType: Codable

    func encode(userSession: UserSessionType) -> Data
    func decode(data: Data) -> UserSessionType
}

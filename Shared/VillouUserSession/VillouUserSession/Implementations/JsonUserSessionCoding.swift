//
//  JsonUserSessionCoding.swift
//  VillouUserSession
//
//  Created by Carlos Villanueva Ousset on 14/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct JsonUserSessionCoding<UserSessionType: Codable>: UserSessionCoding {
    func encode<UserSessionType: Encodable>(userSession: UserSessionType) -> Data {
        try! JSONEncoder().encode(userSession)
    }

    func decode<UserSessionType: Decodable>(data: Data) -> UserSessionType {
        try! JSONDecoder().decode(UserSessionType.self, from: data)
    }
}

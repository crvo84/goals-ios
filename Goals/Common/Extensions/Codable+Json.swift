//
//  Codable+Json.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 14/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

extension Encodable {

    func jsonData(with encoder: JSONEncoder = JSONEncoder()) -> Data {
        return (try? encoder.encode(self)) ?? Data()
    }
}

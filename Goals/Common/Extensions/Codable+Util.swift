//
//  Codable+Util.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

extension Encodable {

    func asData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

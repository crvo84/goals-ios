//
//  DataModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 28/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

protocol DataModel: Codable {}

extension DataModel {

    func toData() -> Data {
        return (try? JSONEncoder().encode(self)) ?? Data()
    }
}

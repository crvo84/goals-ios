//
//  ErrorMessage.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

struct ErrorMessage: Error {

    let id: UUID
    let title: String?
    let message: String?

    init(title: String?, message: String?) {
        self.id = UUID()
        self.title = title
        self.message = message
    }
}

extension ErrorMessage: Equatable {
    static func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
        lhs.id == rhs.id
    }
}

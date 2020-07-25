//
//  MainViewType.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

enum MainViewType: Equatable {
    case splash
    case onboarding
    case signedIn(userSession: UserSession)
}

extension MainViewType {

    static func ==(lhs: MainViewType, rhs: MainViewType) -> Bool {
        switch (lhs, rhs) {
        case (.splash, .splash):
            return true
        case (.onboarding, .onboarding):
            return true
        case let (.signedIn(lSession), .signedIn(rSession)):
            return lSession == rSession
        case (.splash, _), (.onboarding, _), (.signedIn, _):
            return false
        }
    }
}

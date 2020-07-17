//
//  MainViewType.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

enum MainViewType {
    case launching
    case onboarding
    case signedIn(userSession: UserSession)
}

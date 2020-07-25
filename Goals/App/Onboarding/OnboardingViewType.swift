//
//  OnboardingViewType.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

enum OnboardingViewType {
    case welcome
    case signIn
    case signUp
}

extension OnboardingViewType {
    var shouldHideNavigationBar: Bool {
        switch self {
        case .welcome:
            return true
        default:
            return false
        }
    }
}

//
//  NavigationAction.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

enum NavigationAction<ViewType>: Equatable where ViewType: Equatable {
    case present(ViewType)
    case presented(ViewType)
}

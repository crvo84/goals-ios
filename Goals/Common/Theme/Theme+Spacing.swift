//
//  Theme+Geometry.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 27/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    enum Spacing {
        case standard
        case standard2
        case standard3
    }
}

extension Theme.Spacing {
    // if app is universal, update this values depending on device
    // (e.g. return isPad ? 60 : 34)
    var value: CGFloat {
        switch self {
        case .standard: return 8.0
        case .standard2: return 16.0
        case .standard3: return 24.0
        }
    }
}

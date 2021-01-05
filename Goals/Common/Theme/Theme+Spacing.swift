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
        case top
        case bottom
        case leading
        case trailing
        case standard
        case standard2
        case standard3
        case standard4
    }
}

extension Theme.Spacing {
    // if app is universal, update this values depending on device
    // (e.g. return isPad ? 60 : 34)
    var value: CGFloat {
        switch self {
        case .top: return 20
        case .bottom: return 20
        case .leading: return 20
        case .trailing: return 20
        case .standard: return 8
        case .standard2: return 16
        case .standard3: return 24
        case .standard4: return 32
        }
    }
}

extension Theme.Spacing {
    static var contentInsets: (top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
        (top: top.value, bottom: bottom.value, leading: leading.value, trailing: trailing.value)
    }
}

//
//  Theme+CornerRadius.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 25/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    enum CornerRadius {
        case none
        case standard
        case custom(value: CGFloat)

        var value: CGFloat {
            switch self {
            case .none:
                return 0.0
            case .standard:
                return 5.0
            case let .custom(value):
                return value
            }
        }
    }
}

extension UIView {
    func applyTheme(cornerRadius: Theme.CornerRadius) {
        layer.cornerRadius = cornerRadius.value
        layer.masksToBounds = cornerRadius.value > 0
    }
}

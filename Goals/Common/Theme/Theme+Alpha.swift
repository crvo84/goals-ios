//
//  Theme+Alpha.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 25/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    enum Alpha {
        case disabledButton

        var value: CGFloat {
            switch self {
            case .disabledButton:
                return 0.30
            }
        }
    }
}

// MARK: - Helper extensions
extension UIView {
    func apply(alpha: Theme.Alpha) {
        self.alpha = alpha.value
    }
}

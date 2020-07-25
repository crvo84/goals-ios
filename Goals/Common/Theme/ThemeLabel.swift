//
//  ThemeLabel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

// Common label configurations used througout the app
enum ThemeLabel {
    case error(size: ThemeFont.Size)

    var color: ThemeColor {
        switch self {
        case .error:
            return .error
        }
    }

    var font: ThemeFont {
        switch self {
        case let .error(size):
            return ThemeFont(size: size, weight: .bold)
        }
    }
}


// MARK: - Helper extensions
extension UILabel {

    convenience init(themeLabel: ThemeLabel) {
        self.init()
        set(font: themeLabel.font, color: themeLabel.color)
    }
}

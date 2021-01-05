//
//  Theme+Label.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    /// Common label configurations
    enum Label {
        case error

        var color: Theme.Color {
            switch self {
            case .error:
                return .errorTint
            }
        }

        var font: Theme.Font {
            switch self {
            case .error:
                return .callout
            }
        }
    }
}

// MARK: - Helper extensions
extension UILabel {
    convenience init(themeLabel: Theme.Label) {
        self.init()
        self.applyTheme(label: themeLabel)
    }

    func applyTheme(label: Theme.Label) {
        self.applyTheme(font: label.font, color: label.color)
    }
}

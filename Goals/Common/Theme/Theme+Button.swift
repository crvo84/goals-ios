//
//  Theme+Button.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    /// // Common button configurations
    enum Button {
        case primary
        case secondary

        var titleFont: Theme.Font {
            switch self {
            case .primary, .secondary:
                return Font(size: .title)
            }
        }

        var titleColor: Theme.Color {
            switch self {
            case .primary:
                return .textOverMainTint
            case .secondary:
                return .textOverSecondaryTint
            }
        }

        var backgroundColor: Theme.Color? {
            switch self {
            case .primary:
                return .mainTint
            case .secondary:
                return .textOverSecondaryTint
            }
        }

        var cornerRadius: Theme.CornerRadius {
            switch self {
            case .primary, .secondary:
                return .standard
            }
        }
    }
}

// MARK: - Helper extensions
extension UIButton {
    func apply(button: Theme.Button) {
        self.apply(cornerRadius: button.cornerRadius)
        self.setTitleColor(button.titleColor.uiColor, for: .normal)
        self.backgroundColor = button.backgroundColor?.uiColor ?? .clear
        self.titleLabel?.font = button.titleFont.uiFont
    }
}

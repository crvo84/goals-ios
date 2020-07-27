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
        case invertedPrimary
        case invertedSecondary

        var titleFont: Theme.Font {
            switch self {
            case .primary, .secondary, .invertedPrimary, .invertedSecondary:
                return Font.title
            }
        }

        var titleColor: Theme.Color {
            switch self {
            case .primary:
                return .textOverMainTint
            case .secondary:
                return .textOverSecondaryTint
            case .invertedPrimary:
                return .mainTint
            case .invertedSecondary:
                return .secondaryTint
            }
        }

        var backgroundColor: Theme.Color? {
            switch self {
            case .primary:
                return .mainTint
            case .secondary:
                return .textOverSecondaryTint
            case .invertedPrimary, .invertedSecondary:
                return nil
            }
        }

        var cornerRadius: Theme.CornerRadius {
            switch self {
            case .primary, .secondary:
                return .standard
            case .invertedPrimary, .invertedSecondary:
                return .none
            }
        }
    }
}

// MARK: - Helper extensions
extension UIButton {

    convenience init(themeButton: Theme.Button) {
        self.init()
        self.applyTheme(button: themeButton)
    }

    func applyTheme(button: Theme.Button) {
        self.applyTheme(cornerRadius: button.cornerRadius)
        self.setTitleColor(button.titleColor.uiColor, for: .normal)
        self.backgroundColor = button.backgroundColor?.uiColor
        self.titleLabel?.font = button.titleFont.uiFont
    }
}

//
//  Theme+Color.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 21/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

// NOTE: based on https://developer.apple.com/documentation/uikit/uicolor/ui_element_colors
// When in need for a new color, check link for system colors use as base.
extension Theme {
    enum Color {
        // MARK: Tint Colors
        /// Main tint color.
        case mainTint
        /// Secondary tint color.
        case secondaryTint
        /// Error tint color.
        case errorTint

        // MARK: Labels
        /// Color for text layered on top of the main tint color.
        case textOverMainTint
        /// Color for text layered on top of the secondary tint color.
        case textOverSecondaryTint
        /// Color for text labels that contain primary content.
        case primaryLabel
        /// Color for text labels that contain secondary content.
        case secondaryLabel
        /// Color for text labels that contain tertiary content.
        case tertiaryLabel
        /// Color for placeholder text in controls or text views.
        case placeholderText

        // MARK: Backgrounds
        /// Color for the main background.
        case mainBackground
        /// Color for content layered on top of the main background.
        case secondaryBackground
        /// Color for content layered on top of secondary background.
        case tertiaryBackground

        // MARK: Separators
        /// Color for thin borders or divider lines that allows some underlying content to be visible.
        case separator
        /// Color for borders or divider lines that hides any underlying content.
        case opaqueSeparator
    }
}

// MARK: - UIColor
extension Theme.Color {
    private var isDark: Bool {
        UITraitCollection.current.userInterfaceStyle == .dark
    }

    var uiColor: UIColor {
        switch self {
        case .mainTint:
            return UIColor(named: "main-color")!
        case .secondaryTint:
            return .systemGray2 // .systemGray3
        case .errorTint:
            return .systemRed
        case .textOverMainTint:
            return .white
        case .textOverSecondaryTint:
            return isDark ? .white : .label
        case .primaryLabel:
            return .label
        case .secondaryLabel:
            return .secondaryLabel
        case .tertiaryLabel:
            return .tertiaryLabel
        case .placeholderText:
            return .placeholderText
        case .mainBackground:
            return .systemBackground
        case .secondaryBackground:
            return .secondarySystemBackground
        case .tertiaryBackground:
            return .tertiarySystemBackground
        case .separator:
            return .separator
        case .opaqueSeparator:
            return .opaqueSeparator
        }
    }
}

// MARK: - Helper extensions

extension UIView {
    func applyTheme(backgroundColor color: Theme.Color) {
        self.backgroundColor = color.uiColor
    }
}

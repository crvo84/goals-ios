//
//  Theme+Font.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    enum Font {
        /// A font with the large title text style.
        case largeTitle
        /// A font with the title text style.
        case title
        /// Create a font for second level hierarchical headings.
        case title2
        /// Create a font for third level hierarchical headings.
        case title3
        /// A font with the headline text style.
        case headline
        /// A font with the subheadline text style.
        case subheadline
        /// A font with the body text style.
        case body
        /// A font with the callout text style.
        case callout
        /// A font with the caption text style.
        case caption
        /// Create a font with the alternate caption text style.
        case caption2
        /// A font with the footnote text style.
        case footnote
    }
}

extension Theme.Font {
    var uiFont: UIFont {
        var uiFont: UIFont
        switch self {
        case .largeTitle, .title, .title2, .title3, .headline, .subheadline:
            uiFont = .boldSystemFont(ofSize: self.size)
        case .body, .callout, .caption, .caption2, .footnote:
            uiFont = .systemFont(ofSize: self.size)
        }

        return uiFont
    }
}

// MARK: - Font Sizes
extension Theme.Font {
    // if app is universal, update this values depending on device
    // (e.g. return isPad ? 60 : 34)
    var size: CGFloat {
        switch self {
        case .largeTitle:
            return 34
        case .title:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline:
            return 17
        case .subheadline:
            return 15
        case .body:
            return 17
        case .callout:
            return 16
        case .caption:
            return 12
        case .caption2:
            return 11
        case .footnote:
            return 13
        }
    }
}

// MARK: - Helper extensions
extension UILabel {
    func applyTheme(font: Theme.Font, color: Theme.Color) {
        self.font = font.uiFont
        self.textColor = color.uiColor
    }
}

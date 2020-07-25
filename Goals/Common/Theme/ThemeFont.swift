//
//  ThemeFont.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

struct ThemeFont {
    enum Name {
        case system
    }

    enum Size {
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

    enum Weight {
        case regular
        case bold
    }

    let name: Name
    let size: Size
    let weight: Weight

    init(name: Name = .system, size: Size, weight: Weight = .regular) {
        self.name = name
        self.size = size
        self.weight = weight
    }

    var value: UIFont {
        switch name {
        case .system:
            return .systemFont(ofSize: size.value, weight: weight.value)
        }
    }
}

// MARK: - Font Sizes
extension ThemeFont.Size {

    var value: CGFloat {
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

// MARK: - Font Weights
extension ThemeFont.Weight {
    var value: UIFont.Weight {
        switch self {
        case .regular:
            return UIFont.Weight.regular
        case .bold:
            return UIFont.Weight.bold
        }
    }
}

// MARK: - Helper extensions
extension UILabel {

    func set(font: ThemeFont, color: ThemeColor) {
        self.font = font.value
        self.textColor = color.value
    }

    func setFont(name: ThemeFont.Name = .system, size: ThemeFont.Size, weight: ThemeFont.Weight = .regular, color: ThemeColor) {
        let themeFont = ThemeFont(name: name, size: size, weight: weight)
        set(font: themeFont, color: color)
    }
}

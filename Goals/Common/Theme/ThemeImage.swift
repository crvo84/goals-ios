//
//  ThemeImage.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 21/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

enum ThemeImage: String {
    case logo
}

// MARK: - Helper extensions

extension UIImage {
    static func with(_ themeImage: ThemeImage) -> UIImage {
        UIImage(named: themeImage.rawValue)!
    }
}

extension UIImageView {
    convenience init(with themeImage: ThemeImage, tint: ThemeColor? = nil) {
        var image = UIImage.with(themeImage)
        if tint != nil, image.renderingMode != .alwaysTemplate {
            image = image.withRenderingMode(.alwaysTemplate)
        }

        self.init(image: image)

        if let tint = tint {
            self.tintColor = tint.color
        }
    }
}

//
//  Theme+Image.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 21/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    enum Image: String {
        case logo
    }
}

// MARK: - Helper extensions

extension UIImage {
    convenience init(themeImage: Theme.Image) {
        self.init(named: themeImage.rawValue)!
    }
}

extension UIImageView {
    convenience init(themeImage: Theme.Image, tint: Theme.Color? = nil) {
        var image = UIImage(themeImage: themeImage)
        if tint != nil, image.renderingMode != .alwaysTemplate {
            image = image.withRenderingMode(.alwaysTemplate)
        }

        self.init(image: image)

        if let tint = tint {
            self.tintColor = tint.uiColor
        }
    }
}

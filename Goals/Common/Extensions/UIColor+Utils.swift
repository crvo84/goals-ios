//
//  UIColor+Utils.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 21/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension UIColor {

    /// Creates a color object using the specified RGB and alpha values.
    ///
    /// - Parameters:
    ///   - red: Red component. [0, 255]
    ///   - green: Green component. [0, 255]
    ///   - blue: Blue component. [0, 255]
    ///   - alpha: Opacity value [0, 1.0]
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r)/255.0,
                  green: CGFloat(g)/255.0,
                  blue: CGFloat(b)/255.0,
                  alpha: alpha)
    }
}

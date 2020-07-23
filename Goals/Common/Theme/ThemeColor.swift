//
//  ThemeColor.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 21/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

enum ThemeColor {
    case main
    case background
}

extension ThemeColor {

    private var isDark: Bool {
        UITraitCollection.current.userInterfaceStyle == .dark
    }

    var color: UIColor {
        switch self {
        case .main:
            return UIColor(named: "main-color")!
        case .background:
            return UIColor.systemBackground
        }
    }
}

// MARK: - Helper extensions

extension UIView {

    func setBackground(color: ThemeColor) {
        self.backgroundColor = color.color
    }
}

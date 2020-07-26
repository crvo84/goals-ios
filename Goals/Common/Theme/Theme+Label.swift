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
        case error(size: Theme.Font.Size)

        var color: Theme.Color {
            switch self {
            case .error:
                return .errorTint
            }
        }

        var font: Theme.Font {
            switch self {
            case let .error(size):
                return Theme.Font(size: size, weight: .bold)
            }
        }
    }
}

// MARK: - Helper extensions
extension UILabel {
    convenience init(with label: Theme.Label) {
        self.init()
        self.apply(font: label.font, color: label.color)
    }
}

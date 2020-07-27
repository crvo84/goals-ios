//
//  Theme+Size.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 27/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

extension Theme {
    enum Size {
        case largeButton
    }
}

extension Theme.Size {
    // if app is universal, update this values depending on device
    // (e.g. return isPad ? 60 : 34)
    var value: CGSize {
        switch self {
        case .largeButton:
            return .init(width: 200.0, height: 40.0)
        }
    }
}

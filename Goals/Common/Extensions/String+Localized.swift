//
//  String+Localized.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

extension String {

    enum LocalizedKey: String {
        case cancelButton = "Cancel.Button"
    }

    init(localizedKey: LocalizedKey) {
        self.init(NSLocalizedString(localizedKey.rawValue, comment: ""))
    }

    init(localizedKey: LocalizedKey, arguments: CVarArg...) {
        let localizedStr = String(localizedKey: localizedKey)
        self.init(format: localizedStr, arguments)
    }
}

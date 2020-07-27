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
        // MARK: Welcome screen
        case welcomeMessage = "Welcome.Message"
        // MARK: Buttons
        case signUpButton = "Button.SignUp"
        case signInButton = "Button.SignIn"
        case cancelButton = "Button.Cancel"
    }

    init(localized: LocalizedKey) {
        self.init(NSLocalizedString(localized.rawValue, comment: ""))
    }

    init(localized: LocalizedKey, arguments: CVarArg...) {
        let localizedStr = String(localized: localized)
        self.init(format: localizedStr, arguments)
    }
}

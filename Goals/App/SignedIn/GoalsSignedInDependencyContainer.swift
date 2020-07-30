//
//  GoalsSignedInDependencyContainer.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 29/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

class GoalsSignedInDependencyContainer {

    // MARK: - Properties

    // Long-lived dependencies
    private let userSessionRepository: UserSessionRepository
    private let mainViewModel: MainViewModel
    private let signedInViewModel: SignedInViewModel
    private let imageCache: ImageRepository

    // context
    private let userSession: UserSession

}

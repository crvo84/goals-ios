//
//  GoalsSignedInDependencyContainer.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 29/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import VillouImage

class GoalsSignedInDependencyContainer {

    // MARK: - Properties

    // Long-lived dependencies
    private let userSessionRepository: UserSessionRepository
    private let mainViewModel: MainViewModel
    private let signedInViewModel: SignedInViewModel
    private let imageCache: ImageCache

    // context
    private let userSession: UserSession

    // MARK: - Initialization
    init(userSession: UserSession, appDependencyContainer: GoalsAppDependencyContainer) {
        self.userSessionRepository = appDependencyContainer.userSessionRepository
        self.mainViewModel = appDependencyContainer.mainViewModel
        self.userSession = userSession
        self.signedInViewModel = GoalsSignedInDependencyContainer.makeSignedInViewModel()
        self.imageCache = GoalsSignedInDependencyContainer.makeImageCache()
    }

    private static func makeSignedInViewModel() -> SignedInViewModel {
        GoalsSignedInViewModel()
    }

    private static func makeImageCache() -> ImageCache {
        VillouImageCache()
    }

}

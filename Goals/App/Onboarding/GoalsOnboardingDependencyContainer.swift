//
//  GoalsOnboardingDependencyContainer.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 20/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

class GoalsOnboardingDependencyContainer {

    // MARK: - Long lived dependencies

    private let sharedUserSessionRepository: UserSessionRepository
    private let sharedMainViewModel: MainViewModel
    private let sharedOnboardingViewModel: OnboardingViewModel

    // MARK: - Initialization

    init(appDependencyContainer: GoalsAppDependencyContainer) {
        self.sharedUserSessionRepository = appDependencyContainer.sharedUserSessionRepository
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedOnboardingViewModel = GoalsOnboardingDependencyContainer.makeOnboardingViewModel()
    }

    private static func makeOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel()
    }


}

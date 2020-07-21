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

    // shared with parent dependency container
    private let sharedUserSessionRepository: UserSessionRepository
    private let sharedMainViewModel: MainViewModelProtocol

    private let sharedOnboardingViewModel: OnboardingViewModelProtocol

    // MARK: - Initialization

    init(appDependencyContainer: GoalsAppDependencyContainer) {
        
    }

    private func makeOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel()
    }


}

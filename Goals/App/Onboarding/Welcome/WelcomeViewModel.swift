//
//  WelcomeViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

protocol WelcomeViewModel {
    
}

class GoalsWelcomeViewModel: WelcomeViewModel {

    // MARK: - Properties
    private let onboardingNavigator: OnboardingNavigator

    // MARK: - Initialization
    init(onboardingNavigator: OnboardingNavigator) {
        self.onboardingNavigator = onboardingNavigator
    }

    @objc func navigateToSignUp() {
        onboardingNavigator.navigateToSignUp()
    }

    @objc func navigateToSignIn() {
        onboardingNavigator.navigateToSignIn()
    }
}

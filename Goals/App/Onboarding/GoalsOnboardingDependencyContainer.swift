//
//  GoalsOnboardingDependencyContainer.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 20/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import VillouNetworking

class GoalsOnboardingDependencyContainer {

    // MARK: - Properties

    // Long-lived dependencies
    private let userSessionRepository: UserSessionRepository
    private let mainViewModel: MainViewModel
    private let networkingManager: NetworkingManager
    private let onboardingViewModel: OnboardingViewModel

    // MARK: - Initialization
    init(appDependencyContainer: GoalsAppDependencyContainer) {
        self.userSessionRepository = appDependencyContainer.userSessionRepository
        self.mainViewModel = appDependencyContainer.mainViewModel
        self.networkingManager = appDependencyContainer.networkingManager
        self.onboardingViewModel = GoalsOnboardingDependencyContainer.makeOnboardingViewModel()
    }

    private static func makeOnboardingViewModel() -> OnboardingViewModel {
        GoalsOnboardingViewModel()
    }

    // MARK: - Methods
    // Onboarding
    func makeOnboardingViewController() -> OnboardingViewController {
        let welcomeViewController = makeWelcomeViewController()
        let signUpViewController = makeSignUpViewController()
        let signInViewController = makeSignInViewController()

        return OnboardingViewController(viewModel: onboardingViewModel,
                                        welcomeViewController: welcomeViewController,
                                        signUpViewController: signUpViewController,
                                        signInViewController: signInViewController)
    }

    // Welcome
    private func makeWelcomeViewController() -> WelcomeViewController {
        WelcomeViewController(viewModelFactory: self)
    }

    func makeWelcomeViewModel() -> WelcomeViewModel {
        GoalsWelcomeViewModel(onboardingNavigator: onboardingViewModel)
    }

    // Sign Up
    private func makeSignUpViewController() -> SignUpViewController {
        SignUpViewController(viewModelFactory: self)
    }

    func makeSignUpViewModel() -> SignUpViewModel {
        GoalsSignUpViewModel(userSessionRepository: userSessionRepository,
                             userSessionStateResponder: mainViewModel)
    }

    // Sign In
    private func makeSignInViewController() -> SignInViewController {
        SignInViewController(viewModelFactory: self)
    }

    func makeSignInViewModel() -> SignInViewModel {
        GoalsSignInViewModel(userSessionRepository: userSessionRepository,
                             userSessionStateResponder: mainViewModel)
    }
}

extension GoalsOnboardingDependencyContainer: WelcomeViewModelFactory, SignInViewModelFactory, SignUpViewModelFactory {}

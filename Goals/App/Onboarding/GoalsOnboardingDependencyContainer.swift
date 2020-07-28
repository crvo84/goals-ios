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
        GoalsOnboardingViewModel()
    }

    // MARK: - Methods
    // Onboarding
    func makeOnboardingViewController() -> OnboardingViewController {
        let welcomeViewController = makeWelcomeViewController()
        let signUpViewController = makeSignUpViewController()
        let signInViewController = makeSignInViewController()

        return OnboardingViewController(viewModel: sharedOnboardingViewModel,
                                        welcomeViewController: welcomeViewController,
                                        signUpViewController: signUpViewController,
                                        signInViewController: signInViewController)
    }

    // Welcome
    private func makeWelcomeViewController() -> WelcomeViewController {
        WelcomeViewController(viewModelFactory: self)
    }

    func makeWelcomeViewModel() -> WelcomeViewModel {
        GoalsWelcomeViewModel(onboardingNavigator: sharedOnboardingViewModel)
    }

    // Sign Up
    private func makeSignUpViewController() -> SignUpViewController {
        SignUpViewController(viewModelFactory: self)
    }

    func makeSignUpViewModel() -> SignUpViewModel {
        GoalsSignUpViewModel(userSessionRepository: sharedUserSessionRepository,
                             userSessionStateResponder: sharedMainViewModel)
    }

    // Sign In
    private func makeSignInViewController() -> SignInViewController {
        SignInViewController(viewModelFactory: self)
    }

    func makeSignInViewModel() -> SignInViewModel {
        GoalsSignInViewModel(userSessionRepository: sharedUserSessionRepository,
                             userSessionStateResponder: sharedMainViewModel)
    }
}

extension GoalsOnboardingDependencyContainer: WelcomeViewModelFactory, SignInViewModelFactory, SignUpViewModelFactory {}

//
//  GoalsAppDependencyContainer.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit
import VillouNetworking
import VillouSecurity

class GoalsAppDependencyContainer {

    // MARK: - Long lived dependencies

    let sharedUserSessionRepository: UserSessionRepository
    let sharedNetworkingManager: NetworkingManager
    let sharedMainViewModel: MainViewModel

    // MARK: - Initialization

    init() {
        let networkingManager = GoalsAppDependencyContainer.makeNetworkingManager()
        self.sharedNetworkingManager = networkingManager
        self.sharedUserSessionRepository = GoalsAppDependencyContainer.makeUserSessionRepository(with: sharedNetworkingManager)
        self.sharedMainViewModel = GoalsMainViewModel()
    }

    // UserSession

    private static func makeUserSessionRepository(with networkingManager: NetworkingManager) -> UserSessionRepository {
        let dataStore = makeUserSessionDataStore()
        let remoteService = makeUserSessionRemoteService(with: networkingManager)

        return GoalsUserSessionRepository(dataStore: dataStore, remoteService: remoteService)
    }

    private static func makeUserSessionRemoteService(with networkingManager: NetworkingManager) -> UserSessionRemoteService {
        GoalsUserSessionRemoteService(manager: networkingManager)
    }

    private static func makeUserSessionDataStore() -> UserSessionDataStore {
        let secureStore = makeSecureStore()
        return SecureUserSessionDataStore(secureStore: secureStore)
    }

    private static func makeSecureStore() -> SecureStore {
        KeychainSecureStore()
    }

    // Networking

    private static func makeNetworkingManager() -> NetworkingManager {
//        VillouNetworkingManager()
        MockNetworkingManager()
    }
}

// MARK: - Main
extension GoalsAppDependencyContainer: SplashViewModelFactory {
    func makeMainViewController() -> MainViewController {

        MainViewController(viewModel: sharedMainViewModel,
                           splashViewController: makeSplashViewController(),
                           onboardingViewControllerFactory: makeOnboardingViewController,
                           signedInViewControllerFactory: makeSignedInViewController)
    }

    // Splash

    func makeSplashViewController() -> SplashViewController {
        let logoAnimation = HeartbeatSplashLogoAnimation()
        return SplashViewController(splashViewModelFactory: self, logoAnimation: logoAnimation)
    }

    func makeSplashViewModel() -> SplashViewModel {
        GoalsSplashViewModel(userSessionRepository: sharedUserSessionRepository,
                             userSessionStateResponder: sharedMainViewModel)
    }

    // Onboarding

    func makeOnboardingViewController() -> OnboardingViewController {
        // TODO: create from onboarding dependency container
        OnboardingViewController()
    }

    // Signed In

    func makeSignedInViewController(userSession: UserSession) -> SignedInViewController {
        // TODO: create from signed in dependency container
        SignedInViewController()
    }

}

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

    // MARK: - Properties

    // Long-lived dependencies
    let userSessionRepository: UserSessionRepository
    let networkingManager: NetworkingManager
    let mainViewModel: MainViewModel

    // MARK: - Initialization
    init() {
        let networkingManager = GoalsAppDependencyContainer.makeNetworkingManager()
        self.networkingManager = networkingManager
        self.userSessionRepository = GoalsAppDependencyContainer.makeUserSessionRepository(with: networkingManager)
        self.mainViewModel = GoalsMainViewModel()
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
//        let secureStore = makeSecureStore()
//        return SecureUserSessionDataStore(secureStore: secureStore)
        return MockUserSessionDataStore(userSession: nil)
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

        MainViewController(viewModel: mainViewModel,
                           splashViewController: makeSplashViewController(),
                           onboardingViewControllerFactory: makeOnboardingViewController,
                           signedInViewControllerFactory: makeSignedInViewController)
    }

    // Splash
    func makeSplashViewController() -> SplashViewController {
//        let logoAnimation = HeartbeatSplashLogoAnimation()
        let logoAnimation = FloatSplashLogoAnimation()
        return SplashViewController(viewModelFactory: self, logoAnimation: logoAnimation)
    }

    func makeSplashViewModel() -> SplashViewModel {
        GoalsSplashViewModel(userSessionRepository: userSessionRepository,
                             userSessionStateResponder: mainViewModel)
    }

    // Onboarding (Signed Out)
    func makeOnboardingViewController() -> OnboardingViewController {
        let dependencyContainer = GoalsOnboardingDependencyContainer(appDependencyContainer: self)
        return dependencyContainer.makeOnboardingViewController()
    }

    // Signed In
    func makeSignedInViewController(userSession: UserSession) -> SignedInViewController {
        // TODO: create from signed in dependency container
        SignedInViewController()
    }

}

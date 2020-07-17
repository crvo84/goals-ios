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

    // MARK: Long lived dependencies

    let userSessionRepository: UserSessionRepository
    let networkingManager: NetworkingManager
    let mainViewModel: MainViewModel

    // MARK: Initialization

    init() {
        let networkingManager = GoalsAppDependencyContainer.makeNetworkingManager()
        self.networkingManager = networkingManager
        self.userSessionRepository = GoalsAppDependencyContainer.makeUserSessionRepository(with: networkingManager)
        self.mainViewModel = MainViewModel()
    }

    // MARK: UserSession

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

    // MARK: Networking

    private static func makeNetworkingManager() -> NetworkingManager {
//        VillouNetworkingManager()
        MockNetworkingManager()
    }

    // MARK: Main

    func makeMainViewController() -> MainViewController {
        MainViewController()
    }
}

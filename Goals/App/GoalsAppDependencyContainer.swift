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


class GoalsAppDependencyContainer {

    // MARK: Long lived dependencies

//    let userSessionRepository: GoalsUserSessionRepository
    let networkingManager: NetworkingManager
    let mainViewModel: MainViewModel

    // MARK: Initialization

    init() {
//        self.userSessionRepository = GoalsUserSessionRepository<
        self.networkingManager = GoalsAppDependencyContainer.makeNetworkingManager()
        self.mainViewModel = MainViewModel()
    }

    // MARK: UserSession

//    private static func makeUserSessionRepository() -> VillouUserSessionRepository {
//        let dataStore = KeychainUserSessionDataStore<UserSession>()
//        let remoteService = GoalsUserSessionRemoteService(manager: VillouNetworkingManager())
//
//        return VillouUserSessionRepository(dataStore: dataStore, remoteService: remoteService)
//    }
//
//    private static func makeUserSessionCoding() -> UserSessionCoding {
//        VillouUserSessionCoding<GoalsUserSession>(codingType: .json)
//    }

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

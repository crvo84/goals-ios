//
//  GoalsUserSessionRepository.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import VillouUserSession

class GoalsUserSessionRepository: UserSessionRepository {
    
    let dataStore: UserSessionDataStore
    let remoteService: UserSessionRemoteService

    init(dataStore: UserSessionDataStore, remoteService: UserSessionRemoteService) {
        self.dataStore = dataStore
        self.remoteService = remoteService
    }
}

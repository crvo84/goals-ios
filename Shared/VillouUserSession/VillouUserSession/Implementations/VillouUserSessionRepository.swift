//
//  VillouUserSessionRepository.swift
//  VillouUserSession
//
//  Created by Carlos Villanueva Ousset on 15/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public final class VillouUserSessionRepository<DataStore: UserSessionDataStore, RemoteService: UserSessionRemoteService> {

    public let dataStore: DataStore
    public let remoteService: RemoteService

    public init(dataStore: DataStore, remoteService: RemoteService) {
        self.dataStore = dataStore
        self.remoteService = remoteService
    }
}

extension VillouUserSessionRepository: UserSessionRepository where DataStore.UserSessionType == RemoteService.UserSessionType {

    public typealias SignUpDTOType = RemoteService.SignUpDTOType
    public typealias SignInDTOType = RemoteService.SignInDTOType
    public typealias UserSessionType = DataStore.UserSessionType
    public typealias RemoteServiceType = RemoteService
    public typealias DataStoreType = DataStore

    public func readUserSession() -> Single<DataStore.UserSessionType?> {
        dataStore.readUserSession()
    }

    public func signUp(dto: RemoteService.SignUpDTOType) -> Single<DataStore.UserSessionType> {
        remoteService.signUp(dto: dto)
            .flatMap(dataStore.save)
    }

    public func signIn(dto: RemoteService.SignInDTOType) -> Single<DataStore.UserSessionType> {
        remoteService.signIn(dto: dto)
            .flatMap(dataStore.save)
    }

    public func signOut(userSession: DataStore.UserSessionType) -> Single<DataStore.UserSessionType> {
        dataStore.delete(userSession: userSession)
    }
}

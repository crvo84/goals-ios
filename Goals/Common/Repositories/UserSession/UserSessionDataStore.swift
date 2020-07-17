//
//  UserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

protocol UserSessionDataStore {
    func readUserSession() -> Single<UserSession?>
    func save(userSession: UserSession) -> Single<UserSession>
    func delete(userSession: UserSession) -> Completable
    func deleteAllSessions() -> Completable
}

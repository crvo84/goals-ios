//
//  UserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

protocol UserSessionDataStore {
    func readUserSession() -> Single<UserSession?>
    func save(userSession: UserSession) -> Single<UserSession>
    func delete(userSession: UserSession) -> Single<UserSession>
}

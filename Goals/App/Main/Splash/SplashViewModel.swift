//
//  SplashViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

protocol SplashViewModel {
    func loadUserSession()
}

class GoalsSplashViewModel: SplashViewModel {

    private let userSessionRepository: UserSessionRepository
    private let userSessionStateResponder: UserSessionStateResponder

    let bag = DisposeBag()

    init(userSessionRepository: UserSessionRepository,
         userSessionStateResponder: UserSessionStateResponder) {
        self.userSessionRepository = userSessionRepository
        self.userSessionStateResponder = userSessionStateResponder
    }

    func loadUserSession() {
        userSessionRepository.readUserSession()
            .subscribe(onSuccess: routeToNextScreen, onError: handleError)
            .disposed(by: bag)
    }

    private func routeToNextScreen(userSession: UserSession?) {
        switch userSession {
        case .some(let session):
            userSessionStateResponder.respondToSignedIn(with: session)
        case .none:
            userSessionStateResponder.respondToNotSignedIn()
        }
    }

    private func handleError(_ error: Error) {
        routeToNextScreen(userSession: nil)
    }
}

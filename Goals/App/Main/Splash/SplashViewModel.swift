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
    func setIsViewAnimationInProgress(_ inProgress: Bool)
}

class GoalsSplashViewModel: SplashViewModel {

    private struct Config {
        static let shouldWaitForAnimationBeforeRespondingToNotSigned = true
    }

    // MARK: - Properties

    private let userSessionRepository: UserSessionRepository
    private let userSessionStateResponder: UserSessionStateResponder

    private let isViewAnimationInProgress = PublishSubject<Bool>()
    private let shouldRespondToNotSignedInSubject = PublishSubject<Bool>()
    private let bag = DisposeBag()

    private var canRespondToNotSigned: Observable<Bool> {
        guard Config.shouldWaitForAnimationBeforeRespondingToNotSigned else {
            return .just(true)
        }

        return isViewAnimationInProgress.filter { $0 == false }
    }

    // MARK: - Initialization

    init(userSessionRepository: UserSessionRepository,
         userSessionStateResponder: UserSessionStateResponder) {
        self.userSessionRepository = userSessionRepository
        self.userSessionStateResponder = userSessionStateResponder
        setupSubscriptions()
    }

    // MARK: - Setup

    private func setupSubscriptions() {
        let shouldRespondToNotSignedIn = shouldRespondToNotSignedInSubject.filter { $0 == true }
        let callResponder = Observable.combineLatest(canRespondToNotSigned, shouldRespondToNotSignedIn).take(1)

        callResponder
            .subscribe(onNext: { [weak self] _ in
                self?.userSessionStateResponder.respondToNotSignedIn()
            })
            .disposed(by: bag)
    }

    // MARK: - Internal methods

    func loadUserSession() {
        userSessionRepository.readUserSession()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: handleUserSession, onError: handleError)
            .disposed(by: bag)
    }

    func setIsViewAnimationInProgress(_ inProgress: Bool) {
        isViewAnimationInProgress.onNext(inProgress)
    }

    // MARK: - Helper methods

    private func handleUserSession(_ userSession: UserSession?) {
        switch userSession {
        case .some(let session):
            userSessionStateResponder.respondToSignedIn(with: session)
        case .none:
            shouldRespondToNotSignedInSubject.onNext(true)
        }
    }

    private func handleError(_ error: Error) {
        // TODO: display error message? (e.g. no internet connection)
        shouldRespondToNotSignedInSubject.onNext(true)
    }
}

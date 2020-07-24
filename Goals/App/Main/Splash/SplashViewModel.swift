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
    func didCompleteAnimation()
    func didCompleteAnimationCycle()
}

class GoalsSplashViewModel: SplashViewModel {

    private struct Config {
        static let goToOnboardingOnlyWhenAnimationCompletes = true
    }

    // MARK: - Properties

    private let userSessionRepository: UserSessionRepository
    private let userSessionStateResponder: UserSessionStateResponder

    private let animationCompletedSubject = BehaviorSubject<Bool>(value: false)
    private let animationCycleCompletedSubject = PublishSubject<Void>()
    private let notSignedInConfirmedSubject = BehaviorSubject<Bool?>(value: nil)

    private let bag = DisposeBag()

    // MARK: - Initialization

    init(userSessionRepository: UserSessionRepository,
         userSessionStateResponder: UserSessionStateResponder) {
        self.userSessionRepository = userSessionRepository
        self.userSessionStateResponder = userSessionStateResponder

        setupSubscriptions()
    }

    // MARK: - Setup

    private func setupSubscriptions() {
        let canCallNotSignedInResponder = Observable.of(
            animationCompletedSubject.filter { $0 == true },
            animationCycleCompletedSubject.map { true }
        ).merge()

        canCallNotSignedInResponder.withLatestFrom(notSignedInConfirmedSubject)
            .subscribe(onNext: { [weak self] notSignedInConfirmed in
                guard let confirmed = notSignedInConfirmed, confirmed else { return }

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

    func didCompleteAnimation() {
        animationCompletedSubject.onNext(true)
    }

    func didCompleteAnimationCycle() {
        animationCycleCompletedSubject.onNext(())
    }

    // MARK: - Helper methods

    private func handleUserSession(_ userSession: UserSession?) {
        switch userSession {
        case .some(let session):
            userSessionStateResponder.respondToSignedIn(with: session)
        case .none:
            let animationCompleted = (try? animationCompletedSubject.value()) ?? false
            if animationCompleted || Config.goToOnboardingOnlyWhenAnimationCompletes == false {
                userSessionStateResponder.respondToNotSignedIn()
            } else {
                notSignedInConfirmedSubject.onNext(true)
            }
        }
    }

    private func handleError(_ error: Error) {
        // TODO: display error message? (e.g. no internet connection)
        handleUserSession(nil)
    }
}

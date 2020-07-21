//
//  MainViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

protocol MainViewModel: UserSessionStateResponder {
    var viewState: Observable<MainViewState> { get }
}

class GoalsMainViewModel: MainViewModel {

    var viewState: Observable<MainViewState> { viewTypeSubject.asObservable() }
    private let viewTypeSubject = BehaviorSubject<MainViewState>(value: .splash)
}

extension GoalsMainViewModel {

    func respondToSignedIn(with userSession: UserSession) {
        viewTypeSubject.onNext(.signedIn(userSession: userSession))
    }

    func respondToNotSignedIn() {
        viewTypeSubject.onNext(.onboarding)
    }
}

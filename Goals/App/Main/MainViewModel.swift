//
//  MainViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

protocol MainViewModel: UserSessionStateResponder {
    var viewType: Observable<MainViewType> { get }
}

class GoalsMainViewModel: MainViewModel {

    var viewType: Observable<MainViewType> { viewTypeSubject.asObservable() }
    private let viewTypeSubject = PublishSubject<MainViewType>()
}

extension GoalsMainViewModel {

    func respondToSignedIn(with userSession: UserSession) {
        viewTypeSubject.onNext(.signedIn(userSession: userSession))
    }

    func respondToNotSignedIn() {
        viewTypeSubject.onNext(.onboarding)
    }
}

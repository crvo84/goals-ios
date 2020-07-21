//
//  SignedInViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

protocol SignedInViewModel {
    var viewState: Observable<SignedInViewState> { get }
}

class GoalsSignedInViewModel {

    var viewState: Observable<SignedInViewState> { viewTypeSubject.asObservable() }
    private let viewTypeSubject = BehaviorSubject<SignedInViewState>(value: .home)
}

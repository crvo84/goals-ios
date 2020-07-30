//
//  SignedInViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

protocol SignedInViewModel {
    var viewType: Observable<SignedInViewType> { get }
}

class GoalsSignedInViewModel: SignedInViewModel {

    var viewType: Observable<SignedInViewType> { viewTypeSubject.asObservable() }
    private let viewTypeSubject = BehaviorSubject<SignedInViewType>(value: .home)
}

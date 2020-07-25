//
//  OnboardingViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

typealias OnboardingNavigationAction = NavigationAction<OnboardingViewType>

protocol OnboardingViewModel: OnboardingNavigator {
    var navigationAction: Observable<OnboardingNavigationAction> { get }
    func viewTypePresented(_ viewType: OnboardingViewType)
}

class GoalsOnboardingViewModel: OnboardingViewModel {

    var navigationAction: Observable<OnboardingNavigationAction> {
        navigationActionSubject.asObservable()
    }
    private let navigationActionSubject = BehaviorSubject<OnboardingNavigationAction>(value: .present(.welcome))
}

extension GoalsOnboardingViewModel {

    func navigateToSignUp() {
        navigationActionSubject.onNext(.present(.signUp))
    }

    func navigateToSignIn() {
        navigationActionSubject.onNext(.present(.signIn))
    }

    func viewTypePresented(_ viewType: OnboardingViewType) {
        navigationActionSubject.onNext(.presented(viewType))
    }
}

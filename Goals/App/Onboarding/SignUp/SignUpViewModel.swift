//
//  SignUpViewModel.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

protocol SignUpViewModel {

}

class GoalsSignUpViewModel: SignUpViewModel {

    // MARK: - Properties
    private let userSessionRepository: UserSessionRepository
    private let userSessionStateResponder: UserSessionStateResponder

    // MARK: - Initialization
    init(userSessionRepository: UserSessionRepository,
         userSessionStateResponder: UserSessionStateResponder) {
        self.userSessionRepository = userSessionRepository
        self.userSessionStateResponder = userSessionStateResponder
    }
}

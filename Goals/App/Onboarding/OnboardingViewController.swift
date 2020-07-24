//
//  OnboardingViewController.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit

class OnboardingViewController: BaseNavigationController {

    // MARK: - Properties

    private let viewModel: OnboardingViewModel
    private let bag = DisposeBag()

    // children
    private let welcomeViewController: WelcomeViewController
    private let signUpViewController: SignUpViewController
    private let signInViewController: SignInViewController

    // MARK: - Initialization

    init(viewModel: OnboardingViewModel,
         welcomeViewController: WelcomeViewController,
         signUpViewController: SignUpViewController,
         signInViewController: SignInViewController) {
        self.viewModel = viewModel
        self.welcomeViewController = welcomeViewController
        self.signUpViewController = signUpViewController
        self.signInViewController = signInViewController

        super.init()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

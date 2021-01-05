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

        self.delegate = self
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubscriptions()
    }

    // MARK: - Setup
    private func setupSubscriptions() {
        viewModel.navigationAction
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] action in
                self?.respond(to: action)
            })
            .disposed(by: bag)
    }

    // MARK: - Update

    private func respond(to action: OnboardingNavigationAction) {
        switch action {
        case .present(let viewType):
            update(viewType: viewType)
        case .presented:
            break
        }
    }

    private func update(viewType: OnboardingViewType) {
        switch viewType {
        case .welcome:
            presentWelcomeScreen()
        case .signUp:
            presentSignUpScreen()
        case .signIn:
            presentSignInScreen()
        }
    }

    // MARK: - Helper methods

    private func presentWelcomeScreen() {
        pushViewController(welcomeViewController, animated: false)
    }

    private func presentSignUpScreen() {
        pushViewController(signUpViewController, animated: true)
    }

    private func presentSignInScreen() {
        pushViewController(signInViewController, animated: true)
    }

    private func viewType(associatedWith viewController: UIViewController) -> OnboardingViewType? {
        switch viewController {
        case is WelcomeViewController:
            return .welcome
        case is SignUpViewController:
            return .signUp
        case is SignInViewController:
            return .signIn
        default:
            assertionFailure("Unexpected child view controller")
            return nil
        }
    }
}

// MARK: - Navigation Bar Visibility
extension OnboardingViewController {

    private func updateNavigationBarVisibilityIfNeeded(for viewType: OnboardingViewType,
                                                       animated: Bool) {
        if viewType.shouldHideNavigationBar {
            hideNavigationBar(animated: animated)
        } else {
            showNavigationBar(animated: animated)
        }
    }

    private func hideNavigationBar(animated: Bool) {
        guard animated else {
            return setNavigationBarHidden(true, animated: false)
        }

        transitionCoordinator?.animate(alongsideTransition: { context in
            self.setNavigationBarHidden(true, animated: animated)
        })
    }

    private func showNavigationBar(animated: Bool) {
        if self.isNavigationBarHidden {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension OnboardingViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        guard let viewType = viewType(associatedWith: viewController) else { return }

        updateNavigationBarVisibilityIfNeeded(for: viewType, animated: animated)
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let viewType = viewType(associatedWith: viewController) else { return }

        viewModel.viewTypePresented(viewType)
    }
}

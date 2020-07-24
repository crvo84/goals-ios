//
//  MainViewController.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit

class MainViewController: BaseViewController {

    // MARK: - Properties

    private let viewModel: MainViewModel
    private let bag = DisposeBag()

    // children
    private let splashViewController: SplashViewController
    private var signedInViewController: SignedInViewController?
    private var onboardingViewController: OnboardingViewController?

    // factories
    private let makeOnboardingViewController: () -> OnboardingViewController
    private let makeSignedInViewController: (UserSession) -> SignedInViewController

    // MARK: - Initialization

    init(viewModel: MainViewModel,
         splashViewController: SplashViewController,
         onboardingViewControllerFactory: @escaping () -> OnboardingViewController,
         signedInViewControllerFactory: @escaping (UserSession) -> SignedInViewController) {
        self.viewModel = viewModel
        self.splashViewController = splashViewController
        self.makeOnboardingViewController = onboardingViewControllerFactory
        self.makeSignedInViewController = signedInViewControllerFactory

        super.init()
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad()  {
        super.viewDidLoad()

        setupSubscriptions()
        updateState(.splash)
    }

    // MARK: - Setup

    private func setupSubscriptions() {
        viewModel.viewState.distinctUntilChanged()
            .debug("MainViewController viewModel.viewState.distinctUntilChanged")
            .subscribe(onNext: { [weak self] state in
                self?.updateState(state)
            })
            .disposed(by: bag)
    }

    // MARK: - Update

    private func updateState(_ state: MainViewState) {
        switch state {
        case .splash:
            presentSplashScreen()
        case .onboarding:
            guard onboardingViewController?.presentingViewController == nil
                else { return }

            dismissPresentedViewControllerIfNeeded { [weak self] in
                self?.presentOnboardingScreen()
            }
        case .signedIn(let session):
            presentSignedInScreen(userSession: session)
        }
    }

    private func presentSplashScreen() {
        addChildViewController(splashViewController)
    }

    private func presentOnboardingScreen() {
        let onboardingViewController = makeOnboardingViewController()
        onboardingViewController.modalPresentationStyle = .fullScreen
        onboardingViewController.modalTransitionStyle = .crossDissolve
        present(onboardingViewController, animated: true) { [weak self] in
            self?.removeChildViewController(self?.splashViewController)
            self?.removeChildViewController(self?.signedInViewController)
        }
        self.onboardingViewController = onboardingViewController
    }

    private func presentSignedInScreen(userSession: UserSession) {

    }
}

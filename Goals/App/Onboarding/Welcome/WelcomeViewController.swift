//
//  WelcomeViewController.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

protocol WelcomeViewModelFactory {
    func makeWelcomeViewModel() -> WelcomeViewModel
}

class WelcomeViewController: BaseViewController {

    private struct Geometry {
        struct Logo {
            static let aspectRatio = Theme.Logo.Geometry.aspectRatio
            static let relativeHeight = Theme.Logo.Geometry.welcomeRelativeHeight
            static let initialRelativeCenterY = Theme.Logo.Geometry.splashRelativeCenterY
            static let finalRelativeCenterY = Theme.Logo.Geometry.welcomeRelativeCenterY
        }
        struct WelcomeLabel {
            static let relativeTopOffset: CGFloat = 0.25 // relative to logo height
            static let horizontalInset = SharedGeometry.horizontalInset
        }
    }

    private struct Animation {
        static let duration = 0.8
    }

    // MARK: - Properties
    private let welcomeViewModelFactory: WelcomeViewModelFactory
    private var logoInitialCenterYConstraint: NSLayoutConstraint?
    private var logoFinalCenterYConstraint: NSLayoutConstraint?
    private var initialAnimationCompleted = false

    private let logoImageView: UIImageView = {
        UIImageView(themeImage: .logo, tint: .mainTint)
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.applyTheme(font: .largeTitle, color: .primaryLabel)
        label.text = String(localized: .welcomeMessage, arguments: Constants.App.name)
        return label
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.applyTheme(button: .primary)
        button.setTitle(String(localized: .signUpButton), for: .normal)
        return button
    }()

    private let signInButton: UIButton = {
        let button = UIButton()
        button.applyTheme(button: .invertedPrimary)
        button.setTitle(String(localized: .signInButton), for: .normal)
        return button
    }()

    // MARK: - Initialization
    init(welcomeViewModelFactory: WelcomeViewModelFactory) {
        self.welcomeViewModelFactory = welcomeViewModelFactory
        super.init()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startInitialAnimation()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.applyTheme(backgroundColor: .mainBackground)
        setupHierarchy()
        setupConstraintsLogo()
        setupConstraintsSignUpButton()
        setupConstraintsSignInButton()
        setupInitialAnimation()
    }

    private func setupHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
    }

    private func setupConstraintsLogo() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let initialCenterYConstraint = NSLayoutConstraint(item: logoImageView, attribute: .centerY,
                                                          relatedBy: .equal, toItem: view, attribute: .bottom,
                                                          multiplier: Geometry.Logo.initialRelativeCenterY,
                                                          constant: 1.0)
        let finalCenterYConstraint = NSLayoutConstraint(item: logoImageView, attribute: .centerY,
                                                        relatedBy: .equal, toItem: view, attribute: .bottom,
                                                        multiplier: Geometry.Logo.finalRelativeCenterY,
                                                        constant: 1.0)
        NSLayoutConstraint.activate([
            initialCenterYConstraint,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Geometry.Logo.relativeHeight),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: Geometry.Logo.aspectRatio)
        ])

        self.logoInitialCenterYConstraint = initialCenterYConstraint
        self.logoFinalCenterYConstraint = finalCenterYConstraint
    }

    private func setupConstraintsWelcomeLabel() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            NSLayoutConstraint(item: welcomeLabel, attribute: .top, relatedBy: .equal, toItem: , attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
        ])
    }

    private func setupConstraintsSignUpButton() {

    }

    private func setupConstraintsSignInButton() {

    }

    // MARK: - Initial Animation

    private func setupInitialAnimation() {
        [welcomeLabel, signUpButton, signInButton].forEach { $0.alpha = 0.0 }
    }

    private func startInitialAnimation() {
        guard !initialAnimationCompleted else { return }

        animateLogoToFinalPosition { [weak self] in
            self?.animateRemainingUIToFinalState()
        }
    }

    private func animateLogoToFinalPosition(completion: @escaping () -> Void) {
        UIView.animate(withDuration: Animation.duration, delay: 0.0, options: [.curveEaseOut], animations: {
            self.logoInitialCenterYConstraint?.isActive = false
            self.logoFinalCenterYConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }) { _ in
            completion()
        }
    }

    private func animateRemainingUIToFinalState() {
        // TODO: Unhide UI elements
    }
}

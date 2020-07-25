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
        static let logoAspectRatio = ThemeLogo.Geometry.aspectRatio
        static let logoRelativeHeight = ThemeLogo.Geometry.welcomeRelativeHeight
        static let logoInitialRelativeCenterY = ThemeLogo.Geometry.splashRelativeCenterY
        static let logoFinalRelativeCenterY = ThemeLogo.Geometry.welcomeRelativeCenterY
    }

    private struct Animation {
        static let duration = 0.8
    }

    // MARK: - Properties
    private let welcomeViewModelFactory: WelcomeViewModelFactory
    private var logoInitialCenterYConstraint: NSLayoutConstraint?
    private var logoFinalCenterYConstraint: NSLayoutConstraint?

    private let logoImageView: UIImageView = {
        UIImageView.init(with: .logo, tint: .main)
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
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

        animateLogo {
            // TODO: unhide buttons
        }
    }

    // MARK: - Setup
    private func setupUI() {
        view.setBackground(color: .background)
        setupLogo()
    }

    private func setupLogo() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let initialCenterYConstraint = NSLayoutConstraint(item: logoImageView, attribute: .centerY,
                                                          relatedBy: .equal, toItem: view, attribute: .bottom,
                                                          multiplier: Geometry.logoInitialRelativeCenterY,
                                                          constant: 1.0)
        let finalCenterYConstraint = NSLayoutConstraint(item: logoImageView, attribute: .centerY,
                                                        relatedBy: .equal, toItem: view, attribute: .bottom,
                                                        multiplier: Geometry.logoFinalRelativeCenterY,
                                                        constant: 1.0)
        NSLayoutConstraint.activate([
            initialCenterYConstraint,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Geometry.logoRelativeHeight),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: Geometry.logoAspectRatio)
        ])

        self.logoInitialCenterYConstraint = initialCenterYConstraint
        self.logoFinalCenterYConstraint = finalCenterYConstraint
    }

    private func setupSignUpButton() {

    }

    private func setupSignInButton() {

    }

    // MARK: - Update

    private func animateLogo(completion: @escaping () -> Void) {
        UIView.animate(withDuration: Animation.duration, animations: {
            self.logoInitialCenterYConstraint?.isActive = false
            self.logoFinalCenterYConstraint?.isActive = true
            self.view.layoutIfNeeded()

        }, completion: { _ in
            completion()
        })
    }
}

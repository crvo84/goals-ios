//
//  SplashViewController.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit
import SwiftUI

protocol SplashViewModelFactory {
    func makeSplashViewModel() -> SplashViewModel
}

protocol SplashLogoAnimation {
    func startAnimating(logo: UIView)
    func stopAnimating()
}

class SplashViewController: BaseViewController {

    private struct Geometry {
        static let logoAspectRatio: CGFloat = 1.0
        static let logoRelativeHeight: CGFloat = 0.10
        static let logoRelativeCenterY: CGFloat = 0.45
    }

    private struct Animation {
        static let totalDuration = 1.8
        static let beatScale = 1.12
    }

    // MARK: - Properties

    private let viewModel: SplashViewModel
    private let logoAnimation: SplashLogoAnimation?
    private let bag =  DisposeBag()

    private let logoImageView: UIImageView = {
        UIImageView(with: .logo, tint: .main)
    }()

    // MARK: - Initialization

    init(splashViewModelFactory: SplashViewModelFactory, logoAnimation: SplashLogoAnimation?) {
        self.viewModel = splashViewModelFactory.makeSplashViewModel()
        self.logoAnimation = logoAnimation
        super.init()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.loadUserSession()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        logoAnimation?.startAnimating(logo: logoImageView)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        logoAnimation?.stopAnimating()
    }

    // MARK: - Setup

    private func setupUI() {
        view.setBackground(color: .background)
        setupLogo()
    }

    private func setupLogo() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let relativeCenterY = NSLayoutConstraint(item: logoImageView, attribute: .centerY,
                                                 relatedBy: .equal, toItem: view, attribute: .bottom,
                                                 multiplier: Geometry.logoRelativeCenterY, constant: 1.0)
        NSLayoutConstraint.activate([
            relativeCenterY,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Geometry.logoRelativeHeight),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: Geometry.logoAspectRatio)
        ])
    }
}

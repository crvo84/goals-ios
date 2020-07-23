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
    private let bag =  DisposeBag()

    private let logoImageView: UIImageView = {
        UIImageView(with: .logo, tint: .main)
    }()

    // MARK: - Initialization

    init(splashViewModelFactory: SplashViewModelFactory) {
        self.viewModel = splashViewModelFactory.makeSplashViewModel()
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

        animateLogo()
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

    // MARK: - Update

    private func animateLogo() {
        UIView.animateKeyframes(withDuration: Animation.totalDuration, delay: 0.0, options: [], animations: {
            self.addBeatKeyFrames(relativeStart: 0.0, relativeDuration: 0.25)
            self.addBeatKeyFrames(relativeStart: 0.5, relativeDuration: 0.25)
            self.addBeatKeyFrames(relativeStart: 0.75, relativeDuration: 0.25)
        }) { _ in
            // TODO: if user session fetching was completed, go to next screen
            self.animateLogo()
        }
    }

    private func addBeatKeyFrames(relativeStart start: Double, relativeDuration duration: Double) {
        let frameDuration = duration / 2.0
        UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: frameDuration) {
            let beatScale = CGFloat(Animation.beatScale)
            self.logoImageView.transform = CGAffineTransform(scaleX: beatScale, y: beatScale)
        }
        UIView.addKeyframe(withRelativeStartTime: start + frameDuration, relativeDuration: frameDuration) {
            self.logoImageView.transform = .identity
        }
    }
}

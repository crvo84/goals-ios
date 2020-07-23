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
        static let key = "logo-beat"
        static let beatDuration = 0.6
        static let beatScale = 1.12
        static let beatInitialVelocity: CGFloat = 0.5
        static let beatDamping: CGFloat = 0.1
        static let beatCount: Int = 1
        static let durationBetweenBeats = 0.3
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
        animateLogo()
        viewModel.loadUserSession()
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
        let animation = CAAnimationGroup()
        animation.duration = Animation.beatDuration * 2 + Animation.durationBetweenBeats
        animation.repeatCount = Float(Animation.beatCount)
        animation.animations = [singleBeatAnimation()]

        logoImageView.layer.add(animation, forKey: Animation.key)
    }

    private func singleBeatAnimation() -> CASpringAnimation {
        let beat = CASpringAnimation(keyPath: "transform.scale")
        beat.duration = Animation.beatDuration
        beat.fromValue = 1.0
        beat.toValue = Animation.beatScale
        beat.autoreverses = true
        beat.repeatCount = 1
        beat.initialVelocity = Animation.beatInitialVelocity
        beat.damping = Animation.beatDamping

        return beat
    }
}

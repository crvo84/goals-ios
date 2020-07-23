//
//  HeartbeatSplashLogoAnimation.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 22/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

class HeartbeatSplashLogoAnimation: SplashLogoAnimation {

    private struct Config {
        static let totalDuration = 2.0
        static let beatScale = 1.2
    }

    private weak var logo: UIView?

    func startAnimating(logo: UIView) {
        self.logo = logo
        animateLogo()
    }

    func stopAnimating() {
        self.logo?.layer.removeAllAnimations()
        self.logo = nil
    }

    private func animateLogo() {
        guard let logo = logo else { return }

        UIView.animateKeyframes(withDuration: Config.totalDuration, delay: 0.0, options: [], animations: {
            self.addBeatKeyFrames(on: logo, relativeStart: 0.0, relativeDuration: 0.25)
            self.addBeatKeyFrames(on: logo, relativeStart: 0.5, relativeDuration: 0.25)
            self.addBeatKeyFrames(on: logo, relativeStart: 0.75, relativeDuration: 0.25)
        }) { _ in
            self.animateLogo()
        }
    }

    private func addBeatKeyFrames(on view: UIView, relativeStart start: Double, relativeDuration duration: Double) {
        let frameDuration = duration / 2.0
        UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: frameDuration) {
            let beatScale = CGFloat(Config.beatScale)
            view.transform = CGAffineTransform(scaleX: beatScale, y: beatScale)
        }
        UIView.addKeyframe(withRelativeStartTime: start + frameDuration, relativeDuration: frameDuration) {
            view.transform = .identity
        }
    }
}

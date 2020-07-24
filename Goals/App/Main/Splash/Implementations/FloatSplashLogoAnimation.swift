//
//  FloatSplashLogoAnimation.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit

class FloatSplashLogoAnimation: SplashLogoAnimation {

    private struct Config {
        static let totalDuration = 2.0
        static let maxScale = 1.2
    }

    private weak var logo: UIView?

    private let isAnimatingSubject = BehaviorSubject<Bool>(value: false)
    var isAnimating: Observable<Bool> {
        isAnimatingSubject.asObservable()
    }

    func startAnimating(logo: UIView) {
        self.logo = logo
        animateLogo()
    }

    func stopAnimating() {
        self.logo?.layer.removeAllAnimations()
        self.logo = nil
        isAnimatingSubject.onNext(false)
    }

    private func animateLogo() {
        guard let logo = logo else { return }

        isAnimatingSubject.onNext(false)
        UIView.animateKeyframes(withDuration: Config.totalDuration, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                let scale = CGFloat(Config.maxScale)
                logo.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                logo.transform = .identity
            }
        }) { [weak self] _ in
            self?.isAnimatingSubject.onNext(false)
            self?.animateLogo()
        }
    }
}

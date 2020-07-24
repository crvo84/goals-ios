//
//  SplashLogoAnimation.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 23/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit

protocol SplashLogoAnimation {
    var didCompleteAnimationCycle: Observable<Void> { get }
    func startAnimating(logo: UIView)
    func stopAnimating()
}

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

    // MARK: - Properties
    let welcomeViewModelFactory: WelcomeViewModelFactory

    // MARK: - Initialization
    init(welcomeViewModelFactory: WelcomeViewModelFactory) {
        self.welcomeViewModelFactory = welcomeViewModelFactory
        super.init()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

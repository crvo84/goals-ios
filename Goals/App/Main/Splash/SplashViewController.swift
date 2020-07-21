//
//  SplashViewController.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit

protocol SplashViewModelFactory {
    func makeSplashViewModel() -> SplashViewModel
}

class SplashViewController: BaseViewController {

    // MARK: - Properties

    private let viewModel: SplashViewModel
    private let bag =  DisposeBag()

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

    // MARK: - Setup

    private func setupUI() {
        // TODO: remove
        view.backgroundColor = .yellow
    }

}

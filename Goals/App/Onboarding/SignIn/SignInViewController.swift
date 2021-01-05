//
//  SignInViewController.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit

protocol SignInViewModelFactory {
    func makeSignInViewModel() -> SignInViewModel
}

class SignInViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel: SignInViewModel
    private let bag = DisposeBag()

    // MARK: - Initialization
    init(viewModelFactory: SignInViewModelFactory) {
        self.viewModel = viewModelFactory.makeSignInViewModel()
        super.init()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

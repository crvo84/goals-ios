//
//  SignUpViewController.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import UIKit

protocol SignUpViewModelFactory {
    func makeSignUpViewModel() -> SignUpViewModel
}

class SignUpViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel: SignUpViewModel
    private let bag = DisposeBag()

    // MARK: - Initialization
    init(viewModelFactory: SignUpViewModelFactory) {
        self.viewModel = viewModelFactory.makeSignUpViewModel()
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

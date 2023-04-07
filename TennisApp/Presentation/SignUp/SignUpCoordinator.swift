//
//  SignUpCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol SignUpCoordinatorDelegate: AnyObject {
    func signUpCoordinatorDidFinish(signUpCoordinator: SignUpCoordinator)
}

final class SignUpCoordinator: Coordinator,
                               SignUpViewModelCoordinatorDelegate {

    // MARK: Properties

    weak var delegate: SignUpCoordinatorDelegate?
    private let navigationController: UINavigationController
    private let signUpViewController: SignUpViewController

    // MARK: Coordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signUpViewController = SignUpViewController.instantiateViewController()
    }

    func start() {
        let viewModel = SignUpViewModel()
        viewModel.coordinatorDelegate = self
        signUpViewController.viewModel = viewModel
        navigationController.pushViewController(signUpViewController, animated: true)
    }

    // MARK: SignUpViewModelCoordinatorDelegate

    func signUpViewModelRegisterUser(viewModel: SignUpViewModel) {
        delegate?.signUpCoordinatorDidFinish(signUpCoordinator: self)
    }

    func signUpViewModelDidEnd(_ viewModel: SignUpViewModel) {
        delegate?.signUpCoordinatorDidFinish(signUpCoordinator: self)
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

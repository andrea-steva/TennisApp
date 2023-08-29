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

    private let appDIContainer: AppDIContainer
    weak var delegate: SignUpCoordinatorDelegate?

    private let navigationController: UINavigationController
    private let signUpViewController: SignUpViewController

    // MARK: Coordinator

    init(appDIContainer: AppDIContainer,
         navigationController: UINavigationController) {
        self.appDIContainer = appDIContainer
        self.navigationController = navigationController

        let viewModel = SignUpViewModel(userSaveUserCase: appDIContainer.signUpDIContainer.makeUserSaveUse())
        self.signUpViewController = SignUpViewController.instantiateViewController(creator: { coder in
            SignUpViewController(coder: coder, viewModel: viewModel)
        })
    }

    func start() {
        signUpViewController.viewModel.coordinatorDelegate = self
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

//
//  LoginCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorDidFinish(loginCoordinator: LoginCoordinator)
}

final class LoginCoordinator: Coordinator,
                              LoginViewModelCoordinatorDelegate,
                              SignUpCoordinatorDelegate {

    // MARK: Properties

    private let appDIContainer: AppDIContainer
    weak var delegate: LoginCoordinatorDelegate?
    private let navigationController: UINavigationController

    let loginViewController: LoginViewController
    var signUpCoordinator: SignUpCoordinator?

    // MARK: Coordinator

    init(appDIContainer: AppDIContainer,
         navigationController: UINavigationController) {
        self.appDIContainer = appDIContainer
        self.navigationController = navigationController
        self.loginViewController = LoginViewController.instantiateViewController()
    }

    func start() {
        loginViewController.viewModel = LoginViewModel()
        loginViewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(self.loginViewController, animated: true)
    }

    // MARK: LoginViewModelCoordinatorDelegate

    func loginViewModelDidLogin(viewModel: LoginViewModel) {
        delegate?.loginCoordinatorDidFinish(loginCoordinator: self)
    }

    func loginViewModelToSignUp(viewModel: LoginViewModel) {
        signUpCoordinator = SignUpCoordinator(appDIContainer: appDIContainer, navigationController: navigationController)
        signUpCoordinator?.delegate = self
        signUpCoordinator?.start()
    }

    // MARK: SignUpCoordinatorDelegate

    func signUpCoordinatorDidFinish(signUpCoordinator: SignUpCoordinator) {
        _ = navigationController.popViewController(animated: true)
        self.signUpCoordinator = nil
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

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
    
    weak var delegate: LoginCoordinatorDelegate?
    
    private weak var window: UIWindow!
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = true
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    let loginViewController: LoginViewController
    var signUpCoordinator: SignUpCoordinator?
    
    // MARK: Coordinator
    
    init(window: UIWindow) {
        self.window = window
        self.loginViewController = LoginViewController.instantiateViewController()
    }
    
    func start() {
        window.rootViewController = navigationController
        
        loginViewController.viewModel = LoginViewModel()
        loginViewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(self.loginViewController, animated: true)
    }
    
    // MARK: LoginViewModelCoordinatorDelegate
    
    func loginViewModelDidLogin(viewModel: LoginViewModel) {
        delegate?.loginCoordinatorDidFinish(loginCoordinator: self)
    }
    
    func loginViewModelToSignUp(viewModel: LoginViewModel) {
        signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
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

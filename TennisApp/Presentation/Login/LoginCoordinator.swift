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

final class LoginCoordinator: Coordinator, LoginViewModelCoordinatorDelegate, SignUpCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: LoginCoordinatorDelegate?
    
    fileprivate weak var window: UIWindow!
    
    fileprivate let navigationController: UINavigationControllerType = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = true
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    var loginViewController: LoginViewController?
    var signUpCoordinator: SignUpCoordinator?
    
    // MARK: Coordinator
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController else {
            return
        }
        
        window.rootViewController = navigationController as? UIViewController
        
        vc.viewModel = LoginViewModel()
        vc.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(vc, animated: true)
        
        loginViewController = vc
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

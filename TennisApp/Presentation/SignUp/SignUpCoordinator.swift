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

final class SignUpCoordinator: Coordinator, SignUpViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: SignUpCoordinatorDelegate?
    fileprivate weak var navigationController: UINavigationControllerType!
    
    var signUpViewController: SignUpViewController?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignUp") as? SignUpViewController else {
            return
        }
        signUpViewController = vc
        let viewModel = SignUpViewModel()
        viewModel.coordinatorDelegate = self
        signUpViewController!.viewModel = viewModel
        navigationController.pushViewController(signUpViewController!, animated: true)
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

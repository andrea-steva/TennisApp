//
//  LoginViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Bond
import Foundation

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func loginViewModelDidLogin(viewModel: LoginViewModel)
    func loginViewModelToSignUp(viewModel: LoginViewModel)
}

final class LoginViewModel: BaseViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?

    // MARK: Observable

    let email = Observable<String?>("")
    let password = Observable<String?>("")
    let profileImageURL = Observable<URL?>(nil)

    // MARK: Methods

    func toSignUp() {
        self.coordinatorDelegate?.loginViewModelToSignUp(viewModel: self)
    }

    func signIn() {
        guard let email = email.value, let password = password.value else {
            return
        }
        self.isLoadingSubject.send(true)
        FirebaseService.shared.signIn(withEmail: email, password: password) { result in
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let profileImageURL):
                self.profileImageURL.value = profileImageURL
                self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            }
        }
    }
}

//
//  SignUpViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Bond

protocol SignUpViewModelCoordinatorDelegate: AnyObject {
    func signUpViewModelRegisterUser(viewModel: SignUpViewModel)
    func signUpViewModelDidEnd(_ viewModel: SignUpViewModel)
}

final class SignUpViewModel: BaseViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: SignUpViewModelCoordinatorDelegate?

    // MARK: Observable

    let displayName = Observable<String?>("")
    let email = Observable<String?>("")
    let password = Observable<String?>("")

    // MARK: Methods

    func backLogin() {
        self.coordinatorDelegate?.signUpViewModelDidEnd(self)
    }

    func signUp() {
        guard let email = email.value, let password = password.value else {
            return
        }

        self.isLoadingSubject.send(true)
        FirebaseService.shared.createUser(withEmail: email, password: password) { result in
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let user):
                self.setDisplayName(user)
            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            }
        }
    }

    private func setDisplayName(_ user: FirebaseUser) {
        var displayName = self.displayName.value
        if let emailUserName = user.email?.components(separatedBy: "@").first {
            displayName = emailUserName
        }
        let updatedUser = FirebaseUser(providerID: user.providerID, displayName: displayName,
                                       photoURL: user.photoURL, email: user.email)
        FirebaseService.shared.createProfileChangeRequest(user: updatedUser) { result in
            switch result {
            case .success:
                self.coordinatorDelegate?.signUpViewModelRegisterUser(viewModel: self)
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }
}

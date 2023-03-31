//
//  SignUpViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Bond
import Firebase

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

        self.isLoading.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (response, error) in
            self.isLoading.value = false
            if let error = error {
                self.errorMessage.value = error.localizedDescription
                Log.error(error.localizedDescription)
                return
            }
            self.setDisplayName(response!.user)
        }
    }

    private func setDisplayName(_ user: Firebase.User) {

        var displayName = user.email!.components(separatedBy: "@")[0]
        if let name = self.displayName.value {
            displayName = name
        }
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        changeRequest.commitChanges { error in
            if let error = error {
                Log.error(error.localizedDescription)
                return
            }
            FirebaseProxy.sharedInstance.signedIn(Auth.auth().currentUser)
            
            self.coordinatorDelegate?.signUpViewModelRegisterUser(viewModel: self)
        }
    }
}

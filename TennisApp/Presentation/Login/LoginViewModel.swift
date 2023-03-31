//
//  LoginViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Bond
import Firebase

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
        self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
        return 

        guard let email = email.value, let password = password.value else {
            return
        }
        
        self.isLoading.value = true
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.isLoading.value = false
            if let error = error {
                self.errorMessage.value = error.localizedDescription
                Log.error(error.localizedDescription)
                return
            }
            if let profileImageURL = user?.user.photoURL {
                self.profileImageURL.value = profileImageURL
            }
            FirebaseService.sharedInstance.signedIn(user?.user)
            self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
        }
    }
}

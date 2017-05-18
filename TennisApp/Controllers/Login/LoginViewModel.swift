//
//  LoginViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Bond
import Firebase
import FBSDKLoginKit

protocol LoginViewModelCoordinatorDelegate: class {
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
        
        self.isLoading.value = true
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.isLoading.value = false
            if let error = error {
                self.errorMessage.value = error.localizedDescription
                Log.error(error.localizedDescription)
                return
            }
            if let profileImageURL = user?.photoURL {
                self.profileImageURL.value = profileImageURL
            }
            FirebaseProxy.sharedInstance.signedIn(user)
            self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
        }
    }
    
    func signInFacebook(result: FBSDKLoginManagerLoginResult, error: Error!) {
        if let error = error {
            Log.error(error.localizedDescription)
            return
        }
        if result.isCancelled {
            Log.warning("User cancelled login")
            return
        }
        
        self.isLoading.value = true
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            self.isLoading.value = false
            if let error = error {
                self.errorMessage.value = error.localizedDescription
                Log.error(error.localizedDescription)
                return
            }
            if let profileImageURL = user?.photoURL {
                self.profileImageURL.value = profileImageURL
            }
            FirebaseProxy.sharedInstance.signedIn(user!)
            self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
        }
    }
}

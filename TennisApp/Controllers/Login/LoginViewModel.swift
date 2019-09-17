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
            if let profileImageURL = user?.user.photoURL {
                self.profileImageURL.value = profileImageURL
            }
            FirebaseProxy.sharedInstance.signedIn(user?.user)
            self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
        }
    }
    
    func signInFacebook(result: LoginManagerLoginResult, error: Error!) {
        if let error = error {
            Log.error(error.localizedDescription)
            return
        }
        if result.isCancelled {
            Log.warning("User cancelled login")
            return
        }
        
        self.isLoading.value = true
        guard let tokenString = AccessToken.current?.tokenString else {
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        Auth.auth().signIn(with: credential) { (response, error) in
            self.isLoading.value = false
            if let error = error {
                self.errorMessage.value = error.localizedDescription
                Log.error(error.localizedDescription)
                return
            }
            if let profileImageURL = response?.user.photoURL {
                self.profileImageURL.value = profileImageURL
            }
            FirebaseProxy.sharedInstance.signedIn(response!.user)
            self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
        }
    }
}

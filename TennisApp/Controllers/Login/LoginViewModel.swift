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

final class LoginViewModel: BaseViewModel {

    // MARK: Observable

    let email = Observable<String?>("")
    let password = Observable<String?>("")
    let profileImageURL = Observable<URL?>(nil)

    // MARK: Methods

    func signIn() {
        guard let email = email.value, let password = password.value else {
            return
        }

        self.isLoading.value = true
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
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
            AppDelegate.instance.setRootViewController(Utils.getControllerFromStoryboard("Main"))
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
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
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
            AppDelegate.instance.setRootViewController(Utils.getControllerFromStoryboard("Main"))
        }
    }
}

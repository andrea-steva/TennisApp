//
//  SignUpViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Bond
import Firebase

final class SignUpViewModel: BaseViewModel {

    // MARK: Observable

    let displayName = Observable<String?>("")
    let email = Observable<String?>("")
    let password = Observable<String?>("")

    // MARK: Methods

    func signUp() {
        guard let email = email.value, let password = password.value else {
            return
        }

        self.isLoading.value = true
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            self.isLoading.value = false
            if let error = error {
                self.errorMessage.value = error.localizedDescription
                Log.error(error.localizedDescription)
                return
            }
            self.setDisplayName(user!)
        }
    }

    private func setDisplayName(_ user: FIRUser) {

        var displayName = user.email!.components(separatedBy: "@")[0]
        if let name = self.displayName.value {
            displayName = name
        }
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = displayName
        changeRequest.commitChanges() { (error) in
            if let error = error {
                Log.error(error.localizedDescription)
                return
            }
            FirebaseProxy.sharedInstance.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
}

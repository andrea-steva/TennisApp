//
//  SignUpViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    // MARK: View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }
    
    // MARK: Actions
    
    @IBAction func dismissController(_ sender: AnyObject) {
            self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSignUp(_ sender: AnyObject) {
        guard let email = emailField.text, let password = passwordField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                AlertView.showWarning(localizer.get(LocalizedString.generic_alertTitle), message: error.localizedDescription, controller: self)
                Log.error(error.localizedDescription)
                return
            }
            self.setDisplayName(user!)
        }
    }
    
    func setDisplayName(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                Log.error(error.localizedDescription)
                return
            }
            FirebaseProxy.sharedInstance.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
}

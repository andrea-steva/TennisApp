//
//  LoginViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Firebase
import ALCameraViewController
import FBSDKLoginKit

class LoginViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!

    @IBOutlet var cameraButton: UIButton!
    
    @IBOutlet var emailLoginButton: UIButton!
    @IBOutlet var facebookLoginButton: FBSDKLoginButton!
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!

    // MARK: ViewModel
    var viewModel = LoginViewModel()

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.userImageView.layer.cornerRadius = 20.0
        self.userImageView.layer.borderColor = Style.Colors.lightColor.cgColor
        self.userImageView.layer.borderWidth = 5.0

        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
    }

    // MARK: IBAction

    @IBAction func didTapStartButton(_ sender: UIButton) {
        AppDelegate.instance().setRootViewController(Utils.getControllerFromStoryboard("Main"))
    }

    @IBAction func didTapOnCameraButton(_ sender: AnyObject) {

        let cameraViewController = CameraViewController(croppingEnabled: true) { (image, asset) in
            // Do something with your image here.
            // If cropping is enabled this image will be the cropped version
            self.userImageView.image = image
        }
        present(cameraViewController, animated: true, completion: nil)
    }

    // MARK: Firebase Auth
    
    @IBAction func didTapSignIn(_ sender: AnyObject) {
        // Sign In with credentials.
        guard let email = emailField.text, let password = passwordField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.showAlert(title: "Avviso", message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
    }
    @IBAction func didTapSignUp(_ sender: AnyObject) {
        guard let email = emailField.text, let password = passwordField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
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
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    @IBAction func didRequestPasswordReset(_ sender: AnyObject) {
        let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordReset(withEmail: userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil);
    }
    

    func signedIn(_ user: FIRUser?) {
        let notificationName = Notification.Name(rawValue: Constants.NotificationKeys.signedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
        AppDelegate.instance().setRootViewController(Utils.getControllerFromStoryboard("Main"))
    }
    
    // MARK: Facebook login
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                // ...
                return
            }
        }
    }
    
    // MARK: Sign out
    
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

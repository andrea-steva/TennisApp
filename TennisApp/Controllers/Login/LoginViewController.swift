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
        self.userImageView.layer.masksToBounds = true
        
        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // MARK: IBAction
    
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
                AlertView.showWarning(localizer.get(.generic_alertTitle), message: error.localizedDescription, controller: self)
                Log.error(error.localizedDescription)
                return
            }
            FirebaseProxy.sharedInstance.signedIn(user!)
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
                print(error.localizedDescription)
                return
            }
        }
    }
}

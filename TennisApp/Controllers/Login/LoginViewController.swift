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
import Bond
import ReactiveKit

class LoginViewController: BaseViewController, FBSDKLoginButtonDelegate {

    // MARK: IBOutlets
    @IBOutlet var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = 20.0
            userImageView.layer.borderColor = Style.Colors.lightColor.cgColor
            userImageView.layer.borderWidth = 5.0
            userImageView.layer.masksToBounds = true
        }
    }

    @IBOutlet var cameraButton: UIButton!

    @IBOutlet var emailLoginButton: UIButton! {
        didSet {
            emailLoginButton.layer.cornerRadius = 5.0
            emailLoginButton.layer.masksToBounds = true

            emailLoginButton.backgroundColor = UIColor.clear
            emailLoginButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryColor), for: .normal)
            emailLoginButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .highlighted)
            emailLoginButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .disabled)
            emailLoginButton.setTitle(localizer.get(LocalizedString.login_button), for: .normal)
        }
    }

    @IBOutlet var facebookLoginButton: FBSDKLoginButton!

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!

    // MARK: ViewModel
    var viewModel = LoginViewModel()

    override func getViewModel() -> BaseViewModel? {
        return viewModel
    }

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()

        self.facebookLoginButton.delegate = self
        self.facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func bindViewModel() {
        super.bindViewModel()

        viewModel.email.bidirectionalBind(to: emailField.bnd_text)
        viewModel.password.bidirectionalBind(to: passwordField.bnd_text)

        combineLatest(emailField.bnd_text, passwordField.bnd_text) { email, pass in
            return email!.length > 0 && pass!.length > 0
            }
            .bind(to: emailLoginButton.bnd_isEnabled)

        let _ = viewModel.profileImageURL.observeNext { (URL) in
            if let profileImageURL = URL {
                self.userImageView.af_setImage(withURL: profileImageURL)
            }
        }
    }

    // MARK: IBAction

    @IBAction func didTapOnCameraButton(_ sender: AnyObject) {
        let cameraViewController = CameraViewController(croppingEnabled: true) { (image, asset) in
            self.userImageView.image = image
        }
        present(cameraViewController, animated: true, completion: nil)
    }

    // MARK: Firebase Auth

    @IBAction func didTapSignIn(_ sender: AnyObject) {
        self.viewModel.signIn()
    }

    @IBAction func didRequestPasswordReset(_ sender: AnyObject) {
        let prompt = UIAlertController.init(title: "Please insert your email", message: "Email:", preferredStyle: .alert)
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
        present(prompt, animated: true, completion: nil)
    }

    // MARK: FBSDKLoginButtonDelegate

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        self.viewModel.signInFacebook(result: result, error: error)
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {

    }
}

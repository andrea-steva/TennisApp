//
//  LoginViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Firebase
import Bond
import ReactiveKit

final class LoginViewController: BaseViewController, Bindable {
    
    // MARK: IBOutlets

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

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    // MARK: ViewModel
    var viewModel: LoginViewModel!
    
    func getViewModel() -> BaseViewModel? {
        return viewModel
    }
    
    // MARK: View Management
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }
    
    func bindViewModel() {
        
        viewModel.email.bidirectionalBind(to: emailField.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordField.reactive.text)
        
        combineLatest(emailField.reactive.text, passwordField.reactive.text) { email, pass in
            return email!.count > 0 && pass!.count > 0
            }
            .bind(to: emailLoginButton.reactive.isEnabled)
    }
    
    // MARK: IBAction
    
    @IBAction func didTapOnSignUpButton(_ sender: AnyObject) {
        self.viewModel.toSignUp()
    }
        
    // MARK: Firebase Auth
    
    @IBAction func didTapSignIn(_ sender: AnyObject) {
        self.viewModel.signIn()
    }
    
    @IBAction func didRequestPasswordReset(_ sender: AnyObject) {
        let prompt = UIAlertController.init(title: "Please insert your email", message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if userInput!.isEmpty {
                return
            }
            Auth.auth().sendPasswordReset(withEmail: userInput!) { (error) in
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
}

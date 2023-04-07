//
//  LoginViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class LoginViewController: BaseViewController, Bindable, StoryboardInstantiable {

    // MARK: IBOutlets

    @IBOutlet private var emailLoginButton: UIButton! {
        didSet {
            emailLoginButton.layer.cornerRadius = 5.0
            emailLoginButton.layer.masksToBounds = true

            emailLoginButton.backgroundColor = UIColor.clear
            emailLoginButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryColor), for: .normal)
            emailLoginButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .highlighted)
            emailLoginButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .disabled)
            emailLoginButton.setTitle(localizer.get(LocalizationKeys.loginButton), for: .normal)
        }
    }

    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var passwordField: UITextField!

    // MARK: ViewModel

    var viewModel: LoginViewModel!

    func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()

        self.bindViewModel()
        self.bindLoader()
        self.bindAlertMessage()
    }

    func bindViewModel() {

        viewModel.email.bidirectionalBind(to: emailField.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordField.reactive.text)

        combineLatest(emailField.reactive.text, passwordField.reactive.text) { email, pass in
            guard let email, let pass else {
                return false
            }
            return !email.isEmpty && !pass.isEmpty
        }
        .bind(to: emailLoginButton.reactive.isEnabled)
    }

    // MARK: IBAction

    @IBAction private func didTapOnSignUpButton(_ sender: AnyObject) {
        self.viewModel.toSignUp()
    }

    // MARK: Firebase Auth

    @IBAction private func didTapSignIn(_ sender: AnyObject) {
        self.viewModel.signIn()
    }

    @IBAction private func didRequestPasswordReset(_ sender: AnyObject) {
        let prompt = UIAlertController(title: "Please insert your email",
                                       message: "Email:", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let userInput = prompt.textFields?.first?.text, !userInput.isEmpty else {
                return
            }
            FirebaseService.shared.sendPasswordReset(withEmail: userInput)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
}

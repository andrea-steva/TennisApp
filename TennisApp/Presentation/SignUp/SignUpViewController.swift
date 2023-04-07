//
//  SignUpViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Bond
import Firebase
import ReactiveKit
import UIKit

final class SignUpViewController: BaseViewController, Bindable, StoryboardInstantiable {

    // MARK: IBOutlets

    @IBOutlet private var displayNameField: UITextField!
    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var passwordField: UITextField!

    @IBOutlet private var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 5.0
            signUpButton.layer.masksToBounds = true

            signUpButton.backgroundColor = UIColor.clear
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryColor), for: .normal)
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .highlighted)
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .disabled)
            signUpButton.setTitle(localizer.get(LocalizationKeys.signupButton), for: .normal)
        }
    }

    // MARK: ViewModel

    var viewModel = SignUpViewModel()

    func getViewModel() -> BaseViewModel? {
        viewModel
    }

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }

    func bindViewModel() {

        viewModel.displayName.bidirectionalBind(to: displayNameField.reactive.text)
        viewModel.email.bidirectionalBind(to: emailField.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordField.reactive.text)

        combineLatest(emailField.reactive.text, passwordField.reactive.text, displayNameField.reactive.text) { (email, pass, name) -> Bool in
            guard let email, let pass, let name else {
                return false
            }
            return !email.isEmpty && !pass.isEmpty && !name.isEmpty
        }
        .bind(to: signUpButton.reactive.isEnabled)
    }

    // MARK: Actions

    @IBAction private func dismissController(_ sender: AnyObject) {
        self.viewModel.backLogin()
    }

    @IBAction private func didTapSignUp(_ sender: AnyObject) {
        self.viewModel.signUp()
    }
}

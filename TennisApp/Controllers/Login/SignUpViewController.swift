//
//  SignUpViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Firebase
import Bond
import ReactiveKit

class SignUpViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet var displayNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!

    @IBOutlet var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 5.0
            signUpButton.layer.masksToBounds = true

            signUpButton.backgroundColor = UIColor.clear
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryColor), for: .normal)
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .highlighted)
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Style.Colors.primaryPressedColor), for: .disabled)
            signUpButton.setTitle(localizer.get(LocalizedString.signup_button), for: .normal)
        }
    }

    // MARK: ViewModel
    var viewModel = SignUpViewModel()

    override func getViewModel() -> BaseViewModel? {
        return viewModel
    }

    // MARK: View Management
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }

    override func bindViewModel() {
        super.bindViewModel()

        viewModel.displayName.bidirectionalBind(to: displayNameField.reactive.text)
        viewModel.email.bidirectionalBind(to: emailField.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordField.reactive.text)

        combineLatest(emailField.reactive.text, passwordField.reactive.text, displayNameField.reactive.text) { (email, pass, name) -> Bool in
            return email!.length > 0 && pass!.length > 0 && name!.length > 0
            }
            .bind(to: signUpButton.reactive.isEnabled)
    }

    // MARK: Actions

    @IBAction func dismissController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapSignUp(_ sender: AnyObject) {
        self.viewModel.signUp()
    }
}

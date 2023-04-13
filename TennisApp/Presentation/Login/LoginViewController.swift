//
//  LoginViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class LoginViewController: UIViewController, Bindable, StoryboardInstantiable,
                                 BackgroundBlurrable, Localizable, LoadingIndicator, Alertable {

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

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

    // MARK: Properties

    let localizer = Localizer()
    var loadingIndicator: UIActivityIndicatorView?
    var subscriptions = Set<AnyCancellable>()

    // MARK: ViewModel

    var viewModel: LoginViewModelType!

    func getViewModel() -> BindableViewModelType { viewModel }

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""

        self.setBackgroundBlurEffect()

        self.setupBindinds()
        self.bindLoader()
        self.bindAlertMessage()
    }

    private func setupBindinds() {
        // Bidirectional bind view model and UITextiField
        viewModel.emailPublisher
            .compactMap { $0 }
            .assign(to: \.text, on: emailField)
            .store(in: &subscriptions)

        emailField.textPublisher
            .sink(receiveValue: { value in
                self.viewModel.email = value
            })
            .store(in: &subscriptions)

        viewModel.passwordPublisher
            .compactMap { $0 }
            .assign(to: \.text, on: passwordField)
            .store(in: &subscriptions)

        passwordField.textPublisher
            .sink(receiveValue: { value in
                self.viewModel.password = value
            })
            .store(in: &subscriptions)

        viewModel.isSubmitEnabled
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: emailLoginButton)
            .store(in: &subscriptions)
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
            self.viewModel.sendPasswordReset(userInput)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
}

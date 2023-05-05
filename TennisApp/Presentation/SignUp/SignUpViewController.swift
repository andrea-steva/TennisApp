//
//  SignUpViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class SignUpViewController: UIViewController, Bindable, StoryboardInstantiable,
                                  BackgroundBlurrable, Localizable, LoadingIndicator, Alertable {

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var passwordField: UITextField!

    @IBOutlet private var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 5.0
            signUpButton.layer.masksToBounds = true

            signUpButton.backgroundColor = UIColor.clear
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Colors.primaryColor), for: .normal)
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Colors.primaryPressedColor), for: .highlighted)
            signUpButton.setBackgroundImage(UIImage.imageWithColor(Colors.primaryPressedColor), for: .disabled)
            signUpButton.setTitle(localizer.get(LocalizationKeys.signupButton), for: .normal)
        }
    }

    // MARK: Properties

    var loadingIndicator: UIActivityIndicatorView?
    var subscriptions = Set<AnyCancellable>()
    let localizer = Localizer()

    // MARK: ViewModel

    var viewModel: SignUpViewModelType!

    func getViewModel() -> BindableViewModelType { viewModel }

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBackgroundBlurEffect()
        self.setupBindinds()
    }

    private func setupBindinds() {
        viewModel.firstNamePublisher
            .compactMap { $0 }
            .assign(to: \.text, on: firstNameTextField)
            .store(in: &subscriptions)
        firstNameTextField.textPublisher
            .sink(receiveValue: { value in
                self.viewModel.firstName = value
            })
            .store(in: &subscriptions)

        viewModel.lastNamePublisher
            .compactMap { $0 }
            .assign(to: \.text, on: lastNameTextField)
            .store(in: &subscriptions)
        lastNameTextField.textPublisher
            .sink(receiveValue: { value in
                self.viewModel.lastName = value
            })
            .store(in: &subscriptions)

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
            .assign(to: \.isEnabled, on: signUpButton)
            .store(in: &subscriptions)
    }

    // MARK: Actions

    @IBAction private func dismissController(_ sender: AnyObject) {
        self.viewModel.backLogin()
    }

    @IBAction private func didTapSignUp(_ sender: AnyObject) {
        self.viewModel.signUp()
    }
}

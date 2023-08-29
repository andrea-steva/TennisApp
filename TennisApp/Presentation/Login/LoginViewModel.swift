//
//  LoginViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import Foundation

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func loginViewModelDidLogin(viewModel: LoginViewModel)
    func loginViewModelToSignUp(viewModel: LoginViewModel)
}

protocol LoginViewModelType: BindableViewModelType {
    var coordinatorDelegate: LoginViewModelCoordinatorDelegate? { get set }

    var emailPublisher: Published<String>.Publisher { get }
    var email: String { get set }

    var passwordPublisher: Published<String>.Publisher { get }
    var password: String { get set }

    var profileImageURLPublisher: Published<URL?>.Publisher { get }
    var profileImageURL: URL? { get set }

    var isSubmitEnabled: AnyPublisher<Bool, Never> { get }

    func toSignUp()
    func signIn()
    func sendPasswordReset(_ email: String)
}

final class LoginViewModel: LoginViewModelType {

    // MARK: Coordinator

    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?

    // MARK: Properties

    let errorMessageSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    @Published var email = ""
    var emailPublisher: Published<String>.Publisher { $email }

    @Published var password = ""
    var passwordPublisher: Published<String>.Publisher { $password }

    @Published var profileImageURL: URL?
    var profileImageURLPublisher: Published<URL?>.Publisher { $profileImageURL }

    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($email, $password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .eraseToAnyPublisher()
    }

    // MARK: Methods

    func toSignUp() {
        self.coordinatorDelegate?.loginViewModelToSignUp(viewModel: self)
    }

    func signIn() {
        self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
    }

    func sendPasswordReset(_ email: String) {
    }
}

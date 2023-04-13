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

    private let firebaseService: FirebaseServiceType

    let errorMessageSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    @Published var email = "email"
    var emailPublisher: Published<String>.Publisher { $email }

    @Published var password = "password"
    var passwordPublisher: Published<String>.Publisher { $password }

    @Published var profileImageURL: URL?
    var profileImageURLPublisher: Published<URL?>.Publisher { $profileImageURL }

    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($email, $password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .eraseToAnyPublisher()
    }

    // MARK: Methods

    init(firebaseService: FirebaseServiceType = FirebaseService.shared) {
        self.firebaseService = firebaseService
    }

    func toSignUp() {
        self.coordinatorDelegate?.loginViewModelToSignUp(viewModel: self)
    }

    func signIn() {
        self.isLoadingSubject.send(true)
        firebaseService.signIn(withEmail: email, password: password) { result in
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let profileImageURL):
                self.profileImageURL = profileImageURL
                self.coordinatorDelegate?.loginViewModelDidLogin(viewModel: self)
            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            }
        }
    }

    func sendPasswordReset(_ email: String) {
        firebaseService.sendPasswordReset(withEmail: email)
    }
}

//
//  SignUpViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine

protocol SignUpViewModelCoordinatorDelegate: AnyObject {
    func signUpViewModelRegisterUser(viewModel: SignUpViewModel)
    func signUpViewModelDidEnd(_ viewModel: SignUpViewModel)
}

protocol SignUpViewModelType: BindableViewModelType {
    var displayNamePublisher: Published<String>.Publisher { get }
    var displayName: String { get set }

    var emailPublisher: Published<String>.Publisher { get }
    var email: String { get set }

    var passwordPublisher: Published<String>.Publisher { get }
    var password: String { get set }

    var isSubmitEnabled: AnyPublisher<Bool, Never> { get }

    func backLogin()
    func signUp()
}

final class SignUpViewModel: SignUpViewModelType {

    // MARK: Coordinator

    weak var coordinatorDelegate: SignUpViewModelCoordinatorDelegate?

    // MARK: Properties

    private let firebaseService: FirebaseServiceType

    let errorMessageSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    @Published var displayName = "Display Name"
    var displayNamePublisher: Published<String>.Publisher { $displayName }

    @Published var email = "email"
    var emailPublisher: Published<String>.Publisher { $email }

    @Published var password = "password"
    var passwordPublisher: Published<String>.Publisher { $password }

    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($email, $password, $displayName)
            .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }
            .eraseToAnyPublisher()
    }

    // MARK: Methods

    init(firebaseService: FirebaseServiceType = FirebaseService.shared) {
        self.firebaseService = firebaseService
    }

    func backLogin() {
        self.coordinatorDelegate?.signUpViewModelDidEnd(self)
    }

    func signUp() {
        self.isLoadingSubject.send(true)
        firebaseService.createUser(withEmail: email, password: password) { [weak self] result in
            guard let self else { return }
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let user):
                self.setDisplayName(user)
            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            }
        }
    }

    private func setDisplayName(_ user: FirebaseUser) {
        var displayName = self.displayName
        if let emailUserName = user.email?.components(separatedBy: "@").first {
            displayName = emailUserName
        }
        let updatedUser = FirebaseUser(providerID: user.providerID, displayName: displayName,
                                       photoURL: user.photoURL, email: user.email)
        firebaseService.createProfileChangeRequest(user: updatedUser) { result in
            switch result {
            case .success:
                self.coordinatorDelegate?.signUpViewModelRegisterUser(viewModel: self)
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }
}

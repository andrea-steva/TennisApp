//
//  SignUpViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine
import Foundation

protocol SignUpViewModelCoordinatorDelegate: AnyObject {
    func signUpViewModelRegisterUser(viewModel: SignUpViewModel)
    func signUpViewModelDidEnd(_ viewModel: SignUpViewModel)
}

protocol SignUpViewModelType: BindableViewModelType {
    var firstNamePublisher: Published<String>.Publisher { get }
    var firstName: String { get set }

    var lastNamePublisher: Published<String>.Publisher { get }
    var lastName: String { get set }

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
    private let userSaveUserCase: UserSaveUserCase

    let errorMessageSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    @Published var firstName = ""
    var firstNamePublisher: Published<String>.Publisher { $firstName }

    @Published var lastName = ""
    var lastNamePublisher: Published<String>.Publisher { $lastName }

    @Published var email = ""
    var emailPublisher: Published<String>.Publisher { $email }

    @Published var password = ""
    var passwordPublisher: Published<String>.Publisher { $password }

    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4($email, $password, $firstName, $lastName)
            .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty && !$3.isEmpty }
            .eraseToAnyPublisher()
    }

    // MARK: Methods

    init(firebaseService: FirebaseServiceType = FirebaseService.shared,
         userSaveUserCase: UserSaveUserCase) {
        self.firebaseService = firebaseService
        self.userSaveUserCase = userSaveUserCase
    }

    func backLogin() {
        self.coordinatorDelegate?.signUpViewModelDidEnd(self)
    }

    func signUp() {
        self.isLoadingSubject.send(true)

        let user = User(firstName: firstName, lastName: lastName, age: 30, ranking: "NC")
        userSaveUserCase.execute(user: user) { result in
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let success):
                Log.info("User created with \(success) identifier \(user.identifier)")

            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            }
        }
    }
}

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

protocol SignUpViewModelType: ObservableObject, BindableViewModelType {

    var firstName: String { get set }
    var lastName: String { get set }
    var canSubmit: Bool { get }

    var coordinatorDelegate: SignUpViewModelCoordinatorDelegate? { get set }

    func backLogin()
    func signUp()
}

final class SignUpViewModel: ObservableObject, SignUpViewModelType {

    // MARK: Coordinator

    weak var coordinatorDelegate: SignUpViewModelCoordinatorDelegate?

    // MARK: Properties

    private let userSaveUserCase: UserSaveUserCase

    let errorMessageSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    @Published var firstName = ""
    @Published var lastName = ""

    var canSubmit: Bool {
        !firstName.isEmpty && !lastName.isEmpty
    }

    // MARK: Methods

    init(userSaveUserCase: UserSaveUserCase) {
        self.userSaveUserCase = userSaveUserCase
    }

    func backLogin() {
        self.coordinatorDelegate?.signUpViewModelDidEnd(self)
    }

    func signUp() {
        self.isLoadingSubject.send(true)

        let user = User(firstName: firstName, lastName: lastName)
        userSaveUserCase.execute(user: user) { result in
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let success):
                self.coordinatorDelegate?.signUpViewModelRegisterUser(viewModel: self)
                Log.info("User created with \(success) identifier \(user.identifier)")

            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                Log.error(error.localizedDescription)
            }
        }
    }
}

//
//  ProfileViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine

protocol ProfileViewModelCoordinatorDelegate: AnyObject {
}

final class ProfileViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: ProfileViewModelCoordinatorDelegate?

    // MARK: Use Cases

    private let userPrimaryFetchUseCase: UserPrimaryFetchUseCase

    // MARK: Data Source

    private var user: User?

    // MARK: Output

    var reloadViewData: AnyPublisher<Result<Void, Error>, Never> {
        reloadViewDataSubject.eraseToAnyPublisher()
    }

    private let reloadViewDataSubject = PassthroughSubject<Result<Void, Error>, Never>()

    // MARK: Methods

    init(userPrimaryFetchUseCase: UserPrimaryFetchUseCase) {
        self.userPrimaryFetchUseCase = userPrimaryFetchUseCase
    }

    func fetchPrimaryUser() {
        userPrimaryFetchUseCase.execute {  [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                self.user = user
                self.reloadViewDataSubject.send(.success(()))
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }

    func getUserViewModel() -> ProfileHeaderViewModelType? {
        guard let user else {
            return nil
        }
        return ProfileHeaderViewModel(user: user)
    }
}

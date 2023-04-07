//
//  SettingsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol SettingsViewModelCoordinatorDelegate: AnyObject {
    func viewModelDidLogout(viewModel: SettingsViewModel)
}

final class SettingsViewModel: BaseViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?

    // MARK: Methods

    func performLogout(completion: @escaping (Result<Bool, Error>) -> Void) {
        FirebaseService.shared.signOut { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func userDidlogout() {
        coordinatorDelegate?.viewModelDidLogout(viewModel: self)
    }
}

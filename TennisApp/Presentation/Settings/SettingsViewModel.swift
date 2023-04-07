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

    func performLogout(completion: (_ success: Bool, _ error: String?) -> Void) {
        FirebaseService.sharedInstance.signOut { (success, error) in
            if let errorMessage = error {
                Log.error(errorMessage)
            }
            completion(success, error)
        }
    }

    func userDidlogout() {
        coordinatorDelegate?.viewModelDidLogout(viewModel: self)
    }
}

//
//  SettingsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine
import Foundation

protocol SettingsViewModelCoordinatorDelegate: AnyObject {
    func viewModelDidLogout(viewModel: SettingsViewModel)
}

protocol SettingsViewModelType {
    var coordinatorDelegate: SettingsViewModelCoordinatorDelegate? { get set }

    func getFooterText() -> String
    func numberOfSettings() -> Int
    func getSettingsFor(index: Int) -> SettingsItem
    func performLogout(completion: ((Result<Bool, Error>) -> Void)? )
}

final class SettingsViewModel: SettingsViewModelType {

    // MARK: Coordinator

    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?

    // MARK: Properties

    let errorMessageSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    private let firebaseService: FirebaseServiceType
    private let bundle: BundleType

    private var settings: [SettingsItem]

    // MARK: Methods

    init(firebaseService: FirebaseServiceType = FirebaseService.shared, bundle: BundleType = Bundle.main) {
        self.firebaseService = firebaseService
        self.bundle = bundle
        self.settings = [.general, .support, .logout]
    }

    func getFooterText() -> String {
        """
        \(bundle.appDisplayName) \(bundle.appVersion) (\(bundle.appBuildNumber)), Made in Italy 🇮🇹
        © 2023 Andrea Stevanato
        """
    }

    func numberOfSettings() -> Int {
        settings.count
    }

    func getSettingsFor(index: Int) -> SettingsItem {
        // swiftlint:disable:next force_unwrapping
        SettingsItem(rawValue: index)!
    }

    func performLogout(completion: ((Result<Bool, Error>) -> Void)?) {
        isLoadingSubject.send(true)
        firebaseService.signOut { [weak self] result in
            guard let self else { return }
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let success):
                completion?(.success(success))
                self.userDidlogout()
            case .failure(let error):
                self.errorMessageSubject.send(error.localizedDescription)
                completion?(.failure(error))
            }
        }
    }

    func userDidlogout() {
        coordinatorDelegate?.viewModelDidLogout(viewModel: self)
    }
}

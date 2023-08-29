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

protocol SettingsViewModelType: ObservableObject {
    var coordinatorDelegate: SettingsViewModelCoordinatorDelegate? { get set }

    func getFooterText() -> String
    func getSettings() -> [SettingsItem]
    func performLogout(completion: ((Result<Bool, Error>) -> Void)? )
}

final class SettingsViewModel: SettingsViewModelType {

    // MARK: Coordinator

    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?

    // MARK: Properties

    let errorMessageSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    private let bundle: BundleType

    private var settings: [SettingsItem] = [.general, .support, .review, .logout]

    // MARK: Methods

    init(bundle: BundleType = Bundle.main) {
        self.bundle = bundle
    }

    func getFooterText() -> String {
        """
        \(bundle.appDisplayName) \(bundle.appVersion) (\(bundle.appBuildNumber)), Made in Italy 🇮🇹
        © 2023 Andrea Stevanato
        """
    }

    func getSettings() -> [SettingsItem] {
        settings
    }

    func route(for item: SettingsItem) {
        switch item {
        case .general:
            break
        case .support:
            break
        case .review:
            break
        case .logout:
            performLogout(completion: nil)
        }
    }

    func performLogout(completion: ((Result<Bool, Error>) -> Void)?) {
        self.userDidlogout()
    }

    func userDidlogout() {
        coordinatorDelegate?.viewModelDidLogout(viewModel: self)
    }
}

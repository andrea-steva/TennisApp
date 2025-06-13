//
//  SettingsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 01/06/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func settingsCoordinatorUserLogout(settingsCoordinator: SettingsCoordinator)
}

final class SettingsCoordinator: TabBarItemCoordinator,
                                 SettingsViewModelCoordinatorDelegate {

    // MARK: Properties

    weak var delegate: SettingsCoordinatorDelegate?

    private let container: SettingsDIContainer
    private var navigationController: UINavigationController
    private var settingsViewController: SettingsViewController

    // MARK: Coordinator

    init(container: SettingsDIContainer) {
        self.container = container
        self.settingsViewController = SettingsViewController.instantiateViewController(creator: { coder in
            SettingsViewController(coder: coder, viewModel: SettingsViewModel())
        })
        self.navigationController = NavigationControllerBuilder(rootViewController: settingsViewController)
            .setStandardAppearance()
            .setScrollEdgeAppearance()
            .build()
    }

    func start() -> UIViewController {
        settingsViewController.viewModel.coordinatorDelegate = self
        return navigationController
    }

    // MARK: SettingsViewModelCoordinatorDelegate

    func viewModelDidLogout(viewModel: SettingsViewModel) {
        self.delegate?.settingsCoordinatorUserLogout(settingsCoordinator: self)
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

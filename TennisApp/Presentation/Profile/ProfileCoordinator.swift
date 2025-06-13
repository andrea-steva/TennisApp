//
//  ProfileCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 01/06/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol ProfileCoordinatorDelegate: AnyObject {
    func profileCoordinatorDidFinish(profileCoordinator: ProfileCoordinator)
}

final class ProfileCoordinator: TabBarItemCoordinator,
                                ProfileViewModelCoordinatorDelegate {

    // MARK: Properties

    weak var delegate: ProfileCoordinatorDelegate?

    private let container: ProfileDIContainer
    private let navigationController: UINavigationController
    private let profileViewController: ProfileViewController

    // MARK: Coordinator

    init(container: ProfileDIContainer) {
        self.container = container
        self.profileViewController = ProfileViewController.instantiateViewController()
        self.navigationController = NavigationControllerBuilder(rootViewController: profileViewController)
            .setStandardAppearance()
            .setScrollEdgeAppearance()
            .build()
    }

    func start() -> UIViewController {
        profileViewController.viewModel = ProfileViewModel(userPrimaryFetchUseCase: container.makeUserPrimaryFetchUseCase())
        profileViewController.viewModel.coordinatorDelegate = self
        return navigationController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

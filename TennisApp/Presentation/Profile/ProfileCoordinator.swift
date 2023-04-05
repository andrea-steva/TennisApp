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

    private var navigationController: UINavigationControllerType
    private var profileViewController: ProfileViewController
    
    // MARK: Coordinator
    
    init() {
        self.profileViewController = ProfileViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: profileViewController)
    }
    
    func start() -> UIViewController {
        profileViewController.viewModel = ProfileViewModel()
        profileViewController.viewModel.coordinatorDelegate = self
        return navigationController as! UIViewController
    }
    
    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

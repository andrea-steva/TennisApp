//
//  ProfileCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 01/06/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol ProfileCoordinatorDelegate: AnyObject {
    func profileCoordinatorDidFinish(profileCoordinator: ProfileCoordinator)
}

final class ProfileCoordinator: Coordinator, ProfileViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: ProfileCoordinatorDelegate?
    
    private var resideViewController: RESideViewController!
    private var navigationController: UINavigationControllerType = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as! UINavigationControllerType
    
    private var profileViewController: ProfileViewController?
    
    // MARK: Coordinator
    
    init(resideViewController: RESideViewController) {
        self.resideViewController = resideViewController
    }
    
    func start() {
        profileViewController = navigationController.viewControllers.first as? ProfileViewController
        
        profileViewController?.viewModel = ProfileViewModel()
        profileViewController?.viewModel.coordinatorDelegate = self
        
        resideViewController.contentViewController = navigationController as! UIViewController
        resideViewController.hideViewController()
    }
    
    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

//
//  SettingsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 01/06/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol SettingsCoordinatorDelegate: AnyObject {
    func settingsCoordinatorDidFinish(settingsCoordinator: SettingsCoordinator)
}

final class SettingsCoordinator: Coordinator, SettingsViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: SettingsCoordinatorDelegate?
    
    private var resideViewController: RESideViewController!
    private var navigationController: UINavigationControllerType = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController() as! UINavigationControllerType
    
    private var settingsViewController: SettingsViewController?
    
    // MARK: Coordinator
    
    init(resideViewController: RESideViewController) {
        self.resideViewController = resideViewController
    }
    
    func start() {
        settingsViewController = navigationController.viewControllers.first as? SettingsViewController
        
        settingsViewController?.viewModel = SettingsViewModel()
        settingsViewController?.viewModel.coordinatorDelegate = self
        
        resideViewController.contentViewController = navigationController as! UIViewController
        resideViewController.hideViewController()
    }
    
    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

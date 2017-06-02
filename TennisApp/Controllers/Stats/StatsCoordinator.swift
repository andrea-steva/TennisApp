//
//  StatsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol StatsCoordinatorDelegate: class {
    func statsCoordinatorDidFinish(statsCoordinator: StatsCoordinator)
}

class StatsCoordinator: Coordinator, StatsViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: StatsCoordinatorDelegate?
    
    fileprivate var resideViewController: RESideViewController!
    fileprivate var navigationController: UINavigationControllerType = UIStoryboard(name: "Stats", bundle: nil).instantiateInitialViewController() as! UINavigationControllerType
    
    fileprivate var statsViewController: StatsViewController?
    
    // MARK: Coordinator
    
    init(resideViewController: RESideViewController) {
        self.resideViewController = resideViewController
    }
    
    func start() {
        statsViewController = navigationController.viewControllers.first as? StatsViewController
        
        statsViewController?.viewModel = StatsViewModel()
        statsViewController?.viewModel.coordinatorDelegate = self
        
        resideViewController.contentViewController = navigationController as! UIViewController
        resideViewController.hideViewController()
    }
    
    deinit {
        Log.verbose("+++ Deinit \(self) +++")
    }
}

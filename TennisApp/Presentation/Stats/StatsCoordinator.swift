//
//  StatsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol StatsCoordinatorDelegate: AnyObject {
    func statsCoordinatorDidFinish(statsCoordinator: StatsCoordinator)
}

final class StatsCoordinator: Coordinator, StatsViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: StatsCoordinatorDelegate?
    
    private var resideViewController: RESideViewController!
    private var navigationController: UINavigationControllerType = UIStoryboard(name: "Stats", bundle: nil).instantiateInitialViewController() as! UINavigationControllerType
    
    private var statsViewController: StatsViewController?
    
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

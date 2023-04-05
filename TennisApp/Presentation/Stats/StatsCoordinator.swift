//
//  StatsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol StatsCoordinatorDelegate: AnyObject {
    func statsCoordinatorDidFinish(statsCoordinator: StatsCoordinator)
}

final class StatsCoordinator: TabBarItemCoordinator,
                              StatsViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: StatsCoordinatorDelegate?

    private var navigationController: UINavigationControllerType
    private var statsViewController: StatsViewController
    
    // MARK: Coordinator
    
    init() {
        self.statsViewController = StatsViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: statsViewController)
    }
    
    func start() -> UIViewController {
        statsViewController.viewModel = StatsViewModel()
        statsViewController.viewModel.coordinatorDelegate = self
        return navigationController as! UIViewController
    }
    
    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

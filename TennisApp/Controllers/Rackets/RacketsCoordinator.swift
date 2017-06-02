//
//  RacketsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 22/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol RacketsCoordinatorDelegate: class {
    func racketsCoordinatorDidFinish(racketsCoordinator: RacketsCoordinator)
}

class RacketsCoordinator: Coordinator, RacketsViewModelCoordinatorDelegate, StringsCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: RacketsCoordinatorDelegate?
    
    fileprivate var resideViewController: RESideViewController!
    fileprivate var navigationController: UINavigationControllerType = UIStoryboard(name: "Rackets", bundle: nil).instantiateInitialViewController() as! UINavigationControllerType
    
    fileprivate var racketsViewController: RacketsViewController?
    fileprivate var stringsCoordinator: StringsCoordinator?
    
    // MARK: Coordinator
    
    init(resideViewController: RESideViewController) {
        self.resideViewController = resideViewController
    }
    
    func start() {
        racketsViewController = navigationController.viewControllers.first as? RacketsViewController
        
        racketsViewController?.viewModel = RacketsViewModel()
        racketsViewController?.viewModel.coordinatorDelegate = self

        resideViewController.contentViewController = navigationController as! UIViewController
        resideViewController.hideViewController()
    }
    
    // MARK: RacketsViewModelCoordinatorDelegate
    
    func racketsViewModelToStrings(viewModel: RacketsViewModel) {
        stringsCoordinator = StringsCoordinator(navigationController: navigationController)
        stringsCoordinator?.delegate = self
        stringsCoordinator?.start()
    }
    
    // MARK: StringsCoordinatorDelegate
    
    func stringsCoordinatorDidFinish(racketsCoordinator: StringsCoordinator) {
        _ = navigationController.popViewController(animated: true)
        self.stringsCoordinator = nil
    }
    
    deinit {
        Log.verbose("+++ Deinit \(self) +++")
    }
}

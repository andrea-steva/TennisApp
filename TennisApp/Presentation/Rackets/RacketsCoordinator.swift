//
//  RacketsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 22/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol RacketsCoordinatorDelegate: AnyObject {
    func racketsCoordinatorDidFinish(racketsCoordinator: RacketsCoordinator)
}

final class RacketsCoordinator: Coordinator, RacketsViewModelCoordinatorDelegate, StringsCoordinatorDelegate, RacketFormCoordinatorDelegate {
    
    // MARK: Properties
    weak var delegate: RacketsCoordinatorDelegate?
    
    // MARK: Controllers
    private var resideViewController: RESideViewController!
    private var navigationController: UINavigationControllerType = UIStoryboard(name: "Rackets", bundle: nil).instantiateInitialViewController() as! UINavigationControllerType
    
    private var racketsViewController: RacketsViewController?
    
    // MARK: Coordinators
    private var stringsCoordinator: StringsCoordinator?
    private var racketFormCoordinator: RacketFormCoordinator?
    
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
    
    func racketsViewModelToRacketForm(racket: Racket?) {
        racketFormCoordinator = RacketFormCoordinator(navigationController: navigationController, racket: racket)
        racketFormCoordinator?.delegate = self
        racketFormCoordinator?.start()
    }
    
    // MARK: StringsCoordinatorDelegate
    
    func stringsCoordinatorDidFinish(racketsCoordinator: StringsCoordinator) {
        _ = navigationController.popViewController(animated: true)
        self.stringsCoordinator = nil
    }
    
    // MARK: RacketFormCoordinatorDelegate
    
    func racketFormCoordinatorDidFinish(racketFormCoordinator: RacketFormCoordinator) {
        _ = navigationController.popViewController(animated: true)
        self.racketFormCoordinator = nil
    }
    
    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

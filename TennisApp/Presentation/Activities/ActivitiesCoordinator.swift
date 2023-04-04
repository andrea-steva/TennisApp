//
//  ActivitiesCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/06/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol ActivitiesCoordinatorDelegate: AnyObject {
    func activitiesCoordinatorDidFinish(activitiesCoordinator: ActivitiesCoordinator)
}

final class ActivitiesCoordinator: Coordinator {
    
    // MARK: Properties
    
    weak var delegate: ActivitiesCoordinatorDelegate?
    
    private var resideViewController: RESideViewController
    private var navigationController: UINavigationControllerType
    private var activitiesContainerViewController: ActivitiesContainerViewController
    
    // MARK: Coordinator
    
    init(resideViewController: RESideViewController) {
        self.resideViewController = resideViewController
        self.activitiesContainerViewController = ActivitiesContainerViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: activitiesContainerViewController)
    }
    
    func start() {

    
        resideViewController.contentViewController = navigationController as! UIViewController
        resideViewController.hideViewController()
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

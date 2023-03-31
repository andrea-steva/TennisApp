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
    
    private var resideViewController: RESideViewController!
    private var navigationController: UINavigationControllerType = UIStoryboard(name: "Activities", bundle: nil).instantiateViewController(withIdentifier: "ContentViewController") as! UINavigationControllerType
    
    private var activitiesContainerViewController: ActivitiesContainerViewController?
    
    // MARK: Coordinator
    
    init(resideViewController: RESideViewController) {
        self.resideViewController = resideViewController
    }
    
    func start() {
        activitiesContainerViewController = navigationController.viewControllers.first as? ActivitiesContainerViewController
        
        resideViewController.contentViewController = navigationController as! UIViewController
        resideViewController.hideViewController()
    }

    deinit {
        Log.verbose("+++ Deinit \(self) +++")
    }
}

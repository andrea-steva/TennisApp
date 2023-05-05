//
//  ActivitiesCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/06/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol ActivitiesCoordinatorDelegate: AnyObject {
    func activitiesCoordinatorDidFinish(activitiesCoordinator: ActivitiesCoordinator)
}

final class ActivitiesCoordinator: TabBarItemCoordinator {

    // MARK: Properties

    weak var delegate: ActivitiesCoordinatorDelegate?

    private let container: ActivitiesDIContainer
    private let activitiesContainerViewController: ActivitiesContainerViewController
    private let navigationController: UINavigationControllerType

    // MARK: Coordinator

    init(container: ActivitiesDIContainer) {
        self.container = container
        self.activitiesContainerViewController = ActivitiesContainerViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: activitiesContainerViewController)
    }

    func start() -> UIViewController {
        navigationController as! UIViewController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

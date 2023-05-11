//
//  WorkoutsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class WorkoutsCoordinator: TabBarItemCoordinator {

    // MARK: Properties

    private let navigationController: UINavigationControllerType
    private let workoutsViewController: WorkoutsViewController

    // MARK: Coordinator

    init(navigationController: UINavigationControllerType) {
        self.navigationController = navigationController
        self.workoutsViewController = WorkoutsViewController.instantiateViewController()
    }

    func start() -> UIViewController {
        workoutsViewController.viewModel = WorkoutsViewModel()
        return workoutsViewController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

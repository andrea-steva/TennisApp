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

    private var workoutsViewController: WorkoutsViewController
    private let navigationController: UINavigationControllerType

    // MARK: Coordinator

    init() {
        self.workoutsViewController = WorkoutsViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: workoutsViewController)
    }

    func start() -> UIViewController {
        workoutsViewController.viewModel = WorkoutsViewModel()
        return workoutsViewController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

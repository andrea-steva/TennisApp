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

    private let container: StatsDIContainer
    private let navigationController: UINavigationController
    private let statsViewController: StatsViewController

    // MARK: Coordinator

    init(container: StatsDIContainer) {
        self.container = container
        self.statsViewController = StatsViewController.instantiateViewController()
        self.navigationController = NavigationControllerBuilder(rootViewController: statsViewController)
            .setStandardAppearance()
            .setScrollEdgeAppearance()
            .build()
    }

    func start() -> UIViewController {
        statsViewController.viewModel = StatsViewModel()
        statsViewController.viewModel.coordinatorDelegate = self
        return navigationController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

//
//  MatchesCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class MatchesCoordinator: TabBarItemCoordinator {

    // MARK: Properties

    private let navigationController: UINavigationController
    private let matchesViewController: MatchesViewController

    // MARK: Coordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.matchesViewController = MatchesViewController.instantiateViewController()
    }

    func start() -> UIViewController {
        matchesViewController.viewModel = MatchesViewModel()
        return matchesViewController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

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

    private let navigationController: UINavigationControllerType
    private let matchesViewController: MatchesViewController

    // MARK: Coordinator

    init(navigationController: UINavigationControllerType) {
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

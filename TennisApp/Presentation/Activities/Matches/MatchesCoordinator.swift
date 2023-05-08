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

    private var matchesViewController: MatchesViewController
    private let navigationController: UINavigationControllerType

    // MARK: Coordinator

    init() {
        self.matchesViewController = MatchesViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: matchesViewController)
    }

    func start() -> UIViewController {
        matchesViewController.viewModel = MatchesViewModel()
        return matchesViewController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

//
//  PracticesCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class PracticesCoordinator: TabBarItemCoordinator {

    // MARK: Properties

    private let navigationController: UINavigationControllerType
    private let practicesViewController: PracticesViewController

    // MARK: Coordinator

    init(navigationController: UINavigationControllerType) {
        self.navigationController = navigationController
        self.practicesViewController = PracticesViewController.instantiateViewController()
    }

    func start() -> UIViewController {
        practicesViewController.viewModel = PracticesViewModel()
        return practicesViewController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

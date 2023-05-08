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

    private var practicesViewController: PracticesViewController
    private let navigationController: UINavigationControllerType

    // MARK: Coordinator

    init() {
        self.practicesViewController = PracticesViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: practicesViewController)
    }

    func start() -> UIViewController {
        practicesViewController.viewModel = PracticesViewModel()
        return practicesViewController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

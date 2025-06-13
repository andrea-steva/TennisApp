//
//  StringsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 22/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol StringsCoordinatorDelegate: AnyObject {
    func stringsCoordinatorDidFinish(racketsCoordinator: StringsCoordinator)
}

class StringsCoordinator: Coordinator, StringsViewModelCoordinatorDelegate, StringFormCoordinatorDelegate {

    // MARK: Properties

    weak var delegate: StringsCoordinatorDelegate?

    private let container: StringsDIContainer
    private let navigationController: UINavigationController
    private let racket: Racket
    private let stringsViewController: StringsViewController

    private var stringFormCoordinator: StringFormCoordinator?

    // MARK: Coordinator

    init(container: StringsDIContainer,
         navigationController: UINavigationController,
         racket: Racket) {
        self.container = container
        self.navigationController = navigationController
        self.racket = racket
        self.stringsViewController = StringsViewController.instantiateViewController()
    }

    func start() {
        let viewModel = StringsViewModel(stringsFetchUseCase: container.makeStringsFetchUseCase(),
                                         stringDeleteUseCase: container.makeStringsDeleteUseCase(),
                                         racket: racket)
        viewModel.coordinatorDelegate = self
        stringsViewController.viewModel = viewModel
        navigationController.pushViewController(stringsViewController, animated: true)
    }

    // MARK: StringsViewModelCoordinatorDelegate

    func stringViewModelDidEnd(_ viewModel: StringsViewModel) {
        delegate?.stringsCoordinatorDidFinish(racketsCoordinator: self)
    }

    func stringViewModelToStringForm(string: Strings?, racket: Racket) {
        stringFormCoordinator = StringFormCoordinator(navigationController: navigationController,
                                                      racket: racket,
                                                      string: string)
        stringFormCoordinator?.delegate = self
        stringFormCoordinator?.start()
    }

    // MARK: StringFormViewModelCoordinatorDelegate

    func stringFormCoordinatorDidFinish(stringFormCoordinator: StringFormCoordinator) {
        _ = navigationController.popViewController(animated: true)
        self.stringFormCoordinator = nil
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

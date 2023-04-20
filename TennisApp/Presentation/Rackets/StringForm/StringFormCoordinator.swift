//
//  StringFormCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 24/07/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringFormCoordinatorDelegate: AnyObject {
    func stringFormCoordinatorDidFinish(stringFormCoordinator: StringFormCoordinator)
}

class StringFormCoordinator: Coordinator, StringFormViewModelCoordinatorDelegate {

    // MARK: Properties

    private let container = StringsDIContainer()
    weak var delegate: StringFormCoordinatorDelegate?
    private let navigationController: UINavigationControllerType
    private let stringsFromViewController: StringFormViewController
    private var string: Strings?
    private let racket: Racket

    // MARK: Coordinator

    init(navigationController: UINavigationControllerType, racket: Racket, string: Strings?) {
        self.navigationController = navigationController
        self.racket = racket
        self.string = string
        self.stringsFromViewController = StringFormViewController.instantiateViewController()
    }

    func start() {
        if let string = self.string {
            stringsFromViewController.viewModel = StringFormUpdateViewModel(stringsSaveUseCase: container.makeStringsSaveUseCase(),
                                                                            racket: racket,
                                                                            string: string)
        } else {
            stringsFromViewController.viewModel = StringFormCreateViewModel(stringsSaveUseCase: container.makeStringsSaveUseCase(),
                                                                            racket: racket)
        }

        stringsFromViewController.viewModel.coordinatorDelegate = self
        self.navigationController.pushViewController(stringsFromViewController, animated: true)
    }

    // MARK: StringFormViewModelCoordinatorDelegate

    func stringFormViewModelSaveString() {
        delegate?.stringFormCoordinatorDidFinish(stringFormCoordinator: self)
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

//
//  RacketFormCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 24/07/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import UIKit

protocol RacketFormCoordinatorDelegate: AnyObject {
    func racketFormCoordinatorDidFinish(racketFormCoordinator: RacketFormCoordinator)
}

class RacketFormCoordinator: Coordinator, RacketFormViewModelCoordinatorDelegate {

    // MARK: Properties

    private let container = RacketsDIContainer()
    weak var delegate: RacketFormCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var racket: Racket?

    // MARK: Coordinator

    init(navigationController: UINavigationController, racket: Racket?) {
        self.navigationController = navigationController
        self.racket = racket
    }

    func start() {
        let racketFormViewController = RacketFormViewController.instantiateViewController()
        racketFormViewController.viewModel = RacketFormViewModel(racketSaveUseCase: container.makeRacketSaveUseCase(),
                                                                 racket: racket)
        racketFormViewController.viewModel.coordinatorDelegate = self
        self.navigationController.pushViewController(racketFormViewController, animated: true)
    }

    // MARK: RacketFormViewModelCoordinatorDelegate

    func racketFormViewModelSaveRacket() {
        delegate?.racketFormCoordinatorDidFinish(racketFormCoordinator: self)
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

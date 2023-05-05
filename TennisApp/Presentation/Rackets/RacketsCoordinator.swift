//
//  RacketsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 22/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol RacketsCoordinatorDelegate: AnyObject {
    func racketsCoordinatorDidFinish(racketsCoordinator: RacketsCoordinator)
}

final class RacketsCoordinator: TabBarItemCoordinator,
                                RacketsViewModelCoordinatorDelegate,
                                StringsCoordinatorDelegate,
                                RacketFormCoordinatorDelegate {

    // MARK: Properties

    typealias RacketsCoordinatorContainer = (rackets: RacketsDIContainer, strings: StringsDIContainer)
    
    private let container: RacketsCoordinatorContainer

    weak var delegate: RacketsCoordinatorDelegate?

    // MARK: Controllers

    private let navigationController: UINavigationControllerType
    private let racketsViewController: RacketsViewController

    // MARK: Coordinators

    private var stringsCoordinator: StringsCoordinator?
    private var racketFormCoordinator: RacketFormCoordinator?

    // MARK: Coordinator

    init(container: RacketsCoordinatorContainer) {
        self.container = container
        self.racketsViewController = RacketsViewController.instantiateViewController()
        self.navigationController = UINavigationController(rootViewController: racketsViewController)
    }

    func start() -> UIViewController {
        racketsViewController.viewModel = RacketsViewModel(racketsFetchUseCase: container.rackets.makeRacketsFetchUseCase(),
                                                           racketDeleteUseCase: container.rackets.makeRacketDeleteUseCase())
        racketsViewController.viewModel.coordinatorDelegate = self
        return navigationController as! UIViewController
    }

    // MARK: RacketsViewModelCoordinatorDelegate

    func racketsViewModelToStrings(racket: Racket) {
        stringsCoordinator = StringsCoordinator(container: container.strings,
                                                navigationController: navigationController,
                                                racket: racket)
        stringsCoordinator?.delegate = self
        stringsCoordinator?.start()
    }

    func racketsViewModelToRacketForm(racket: Racket?) {
        racketFormCoordinator = RacketFormCoordinator(navigationController: navigationController, racket: racket)
        racketFormCoordinator?.delegate = self
        racketFormCoordinator?.start()
    }

    // MARK: StringsCoordinatorDelegate

    func stringsCoordinatorDidFinish(racketsCoordinator: StringsCoordinator) {
        _ = navigationController.popViewController(animated: true)
        self.stringsCoordinator = nil
    }

    // MARK: RacketFormCoordinatorDelegate

    func racketFormCoordinatorDidFinish(racketFormCoordinator: RacketFormCoordinator) {
        _ = navigationController.popViewController(animated: true)
        self.racketFormCoordinator = nil
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

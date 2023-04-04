//
//  RacketFormCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 24/07/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketFormCoordinatorDelegate: AnyObject {
    func racketFormCoordinatorDidFinish(racketFormCoordinator: RacketFormCoordinator)
}

class RacketFormCoordinator: Coordinator, RacketFormViewModelCoordinatorDelegate {
    
    // MARK: Properties

    private let container = RacketsDIContainer()
    weak var delegate: RacketFormCoordinatorDelegate?
    fileprivate weak var navigationController: UINavigationControllerType?
    private var racket: Racket?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType, racket: Racket?) {
        self.navigationController = navigationController
        self.racket = racket
    }
    
    func start() {
        let formVC = RacketFormViewController.instantiateViewController()
        formVC.viewModel = RacketFormViewModel(racketCreateUseCase: container.makeRacketCreateUseCase(),
                                               racketUpdateUseCase: container.makeRacketUpdateUseCase(),
                                               racket: racket)
        formVC.viewModel.coordinatorDelegate = self
        self.navigationController?.pushViewController(formVC, animated: true)
    }
    
    // MARK: RacketFormViewModelCoordinatorDelegate
    
    func racketFormViewModelSaveRacket() {
        delegate?.racketFormCoordinatorDidFinish(racketFormCoordinator: self)
    }
    
    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

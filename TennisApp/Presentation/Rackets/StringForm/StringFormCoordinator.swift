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
    private let formVC: StringFormViewController
    private var string: Strings?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType, string: Strings?) {
        self.navigationController = navigationController
        self.string = string
        self.formVC = StringFormViewController.instantiateViewController()
    }
    
    func start() {
        formVC.viewModel = StringFormViewModel(stringsCreateUseCase: container.makeStringsCreateUseCase(),
                                               stringsUpdateUseCase: container.makeStringsUpdateUseCase(),
                                               string: string)
        formVC.viewModel.coordinatorDelegate = self
        self.navigationController.pushViewController(formVC, animated: true)
    }
    
    // MARK: StringFormViewModelCoordinatorDelegate
    
    func stringFormViewModelSaveString() {
        delegate?.stringFormCoordinatorDidFinish(stringFormCoordinator: self)
    }
    
    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

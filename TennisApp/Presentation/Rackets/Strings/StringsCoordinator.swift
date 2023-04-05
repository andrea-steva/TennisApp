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

    private let container = StringsDIContainer()
    weak var delegate: StringsCoordinatorDelegate?
    private let navigationController: UINavigationControllerType
    private let stringsViewController: StringsViewController!

    private var stringFormCoordinator: StringFormCoordinator?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType) {
        self.navigationController = navigationController
        self.stringsViewController = StringsViewController.instantiateViewController()
    }
    
    func start() {
        let viewModel = StringsViewModel(stringsFetchUseCase: container.makeStringsFetchUseCase())
        viewModel.coordinatorDelegate = self
        stringsViewController.viewModel = viewModel
        navigationController.pushViewController(stringsViewController, animated: true)
    }
    
    // MARK: StringsViewModelCoordinatorDelegate
    
    func stringViewModelDidEnd(_ viewModel: StringsViewModel) {
        delegate?.stringsCoordinatorDidFinish(racketsCoordinator: self)
    }
    
    func stringViewModelToStringForm(string: Strings?) {
        stringFormCoordinator = StringFormCoordinator(navigationController: navigationController, string: string)
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

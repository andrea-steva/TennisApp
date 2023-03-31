//
//  StringsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 22/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol StringsCoordinatorDelegate: class {
    func stringsCoordinatorDidFinish(racketsCoordinator: StringsCoordinator)
}

class StringsCoordinator: Coordinator, StringsViewModelCoordinatorDelegate, StringFormCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: StringsCoordinatorDelegate?
    fileprivate weak var navigationController: UINavigationControllerType!
    
    var stringsViewController: StringsViewController!
    
    private var stringFormCoordinator: StringFormCoordinator?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType) {
        self.navigationController = navigationController
    }
    
    func start() {
        stringsViewController = StringsViewController.instantiateFromStoryboard("Strings") as! StringsViewController
        
        let viewModel = StringsViewModel()
        viewModel.coordinatorDelegate = self
        stringsViewController.viewModel = viewModel
        navigationController?.pushViewController(stringsViewController, animated: true)
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
        Log.verbose("+++ Deinit \(self) +++")
    }
}

//
//  StringFormCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 24/07/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringFormCoordinatorDelegate: class {
    func stringFormCoordinatorDidFinish(stringFormCoordinator: StringFormCoordinator)
}

class StringFormCoordinator: Coordinator, StringFormViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: StringFormCoordinatorDelegate?
    fileprivate weak var navigationController: UINavigationControllerType?
    fileprivate var formVC: StringFormViewController!
    fileprivate var string: Strings?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType, string: Strings?) {
        self.navigationController = navigationController
        self.string = string
    }
    
    func start() {
        
        formVC = StringFormViewController.instantiateFromStoryboard("Strings") as! StringFormViewController
        
        formVC.viewModel = StringFormViewModel(string: string)
        formVC.viewModel.coordinatorDelegate = self
        self.navigationController?.pushViewController(formVC, animated: true)
    }
    
    // MARK: StringFormViewModelCoordinatorDelegate
    
    func stringFormViewModelSaveString() {
        delegate?.stringFormCoordinatorDidFinish(stringFormCoordinator: self)
    }
    
    deinit {
        Log.verbose("+++ Deinit \(self) +++")
    }
}

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
    
    weak var delegate: StringFormCoordinatorDelegate?
    fileprivate weak var navigationController: UINavigationControllerType?
    private var formVC: StringFormViewController!
    private var string: StringsEntity?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType, string: StringsEntity?) {
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
        Log.debug("+++ Deinit \(self) +++")
    }
}

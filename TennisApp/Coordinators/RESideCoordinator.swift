//
//  RESideCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 09/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol RESideCoordinatorDelegate: class {
    func resideCoordinatorDidFinish(resideCoordinator: RESideCoordinator)
}

class RESideCoordinator: Coordinator, RESideViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: RESideCoordinatorDelegate?
    fileprivate weak var window: UIWindow?
    
    var resideViewController: RESideViewController?
    
    // MARK: Coordinator
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Activities", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RESide") as? RESideViewController else {
            return
        }
        
        vc.viewModel = RESideViewModel()
        vc.viewModel.coordinatorDelegate = self
        
        resideViewController = vc
        window?.rootViewController = resideViewController
    }
    
    // MARK: RESideViewModelCoordinatorDelegate
    
    func resideViewModelDidLogout(viewModel: RESideViewModel) {
        self.delegate?.resideCoordinatorDidFinish(resideCoordinator: self)
    }
    
    deinit {
        Log.verbose("Deinit \(self)")
    }
}

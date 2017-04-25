//
//  RESideCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 09/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol RESideCoordinatorDelegate: class  {
    func resideCoordinatorDidFinish(resideCoordinator: RESideCoordinator)
}

class RESideCoordinator: Coordinator {
    
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
        resideViewController = vc
        window?.rootViewController = resideViewController
    }

    deinit {
        Log.verbose("Deinit \(self)")
    }
}


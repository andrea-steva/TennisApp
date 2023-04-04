//
//  RESideViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RESideViewModelCoordinatorDelegate: AnyObject {
    func resideViewModelDidLogout(viewModel: RESideViewModel)
    func resideViewModelPresent(menuItem: RESideMenuItem)
}

final class RESideViewModel {
    
    // MARK: Coordinator
    
    weak var coordinatorDelegate: RESideViewModelCoordinatorDelegate?
    
    // MARK: Methods
    
    func performLogout(completion: (_ success: Bool, _ error: String?) -> Void) {
        FirebaseService.sharedInstance.signOut { (success, error) in
            if let errorMessage = error {
                Log.error(errorMessage)
            }
            completion(success, error)
        }
    }
    
    func userDidlogout() {
        coordinatorDelegate?.resideViewModelDidLogout(viewModel: self)
    }
    
    func userSelect(menuItem: RESideMenuItem) {
        coordinatorDelegate?.resideViewModelPresent(menuItem: menuItem)
    }
}

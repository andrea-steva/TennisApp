//
//  RESideViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import FBSDKLoginKit

protocol RESideViewModelCoordinatorDelegate: class {
    func resideViewModelDidLogout(viewModel: RESideViewModel)
    func resideViewModelPresent(menuItem: MenuItem)
}

final class RESideViewModel {
    
    // MARK: Coordinator
    
    weak var coordinatorDelegate: RESideViewModelCoordinatorDelegate?
    
    // MARK: Methods
    
    func performLogout(completion: (_ success: Bool, _ error: String?) -> Void) {
        FirebaseProxy.sharedInstance.signOut { (success, error) in
            if let errorMessage = error {
                Log.error(errorMessage)
            }
            AccessToken.current = nil
            Profile.current = nil
            completion(success, error)
        }
    }
    
    func userDidlogout() {
        coordinatorDelegate?.resideViewModelDidLogout(viewModel: self)
    }
    
    func userSelect(menuItem: MenuItem) {
        coordinatorDelegate?.resideViewModelPresent(menuItem: menuItem)
    }
}

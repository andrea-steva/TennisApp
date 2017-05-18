//
//  RESideViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RESideViewModelCoordinatorDelegate: class {
    func resideViewModelDidLogout(viewModel: RESideViewModel)
}

final class RESideViewModel {
    
    // MARK: Coordinator
    weak var coordinatorDelegate: RESideViewModelCoordinatorDelegate?
    
    // MARK: Methods
    
    func logout() {
        self.coordinatorDelegate?.resideViewModelDidLogout(viewModel: self)
    }
}

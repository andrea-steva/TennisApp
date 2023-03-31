//
//  SettingsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol SettingsViewModelCoordinatorDelegate: AnyObject {
    
}

final class SettingsViewModel: BaseViewModel {

    // MARK: Coordinator
    
    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?
}

//
//  StatsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol StatsViewModelCoordinatorDelegate: AnyObject {
    
}

final class StatsViewModel: BaseViewModel {

    // MARK: Coordinator
    
    weak var coordinatorDelegate: StatsViewModelCoordinatorDelegate?
}

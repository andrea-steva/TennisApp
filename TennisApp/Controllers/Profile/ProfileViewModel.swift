//
//  ProfileViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RealmSwift

protocol ProfileViewModelCoordinatorDelegate: class {
    
}

final class ProfileViewModel: BaseViewModel {

    // MARK: Coordinator
    
    weak var coordinatorDelegate: ProfileViewModelCoordinatorDelegate?
}

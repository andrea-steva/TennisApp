//
//  RESideCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 09/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol RESideCoordinatorDelegate: AnyObject {
    func resideCoordinatorDidFinish(resideCoordinator: RESideCoordinator)
}

final class RESideCoordinator: Coordinator,
    RESideViewModelCoordinatorDelegate,
    ActivitiesCoordinatorDelegate,
    RacketsCoordinatorDelegate,
    StatsCoordinatorDelegate,
    ProfileCoordinatorDelegate,
SettingsCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: RESideCoordinatorDelegate?
    fileprivate weak var window: UIWindow!
    
    var resideViewController: RESideViewController = RESideViewController.instantiateFromStoryboard("RESide")
    
    var activitiesCoordinator: ActivitiesCoordinator?
    var racketsCoordinator: RacketsCoordinator?
    var statsCoordinator: StatsCoordinator?
    var profileCoordinator: ProfileCoordinator?
    var settingsCoordinator: SettingsCoordinator?
    
    // MARK: Coordinator
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        resideViewController.viewModel = RESideViewModel()
        resideViewController.viewModel.coordinatorDelegate = self
        window.rootViewController = resideViewController
    }
    
    // MARK: RESideViewModelCoordinatorDelegate
    
    func resideViewModelDidLogout(viewModel: RESideViewModel) {
        self.delegate?.resideCoordinatorDidFinish(resideCoordinator: self)
    }
    
    func resideViewModelPresent(menuItem: MenuItem) {
        
        self.activitiesCoordinator = nil
        self.racketsCoordinator = nil
        self.statsCoordinator = nil
        self.profileCoordinator = nil
        self.settingsCoordinator = nil
        
        switch menuItem {
        case .activities:
            activitiesCoordinator = ActivitiesCoordinator(resideViewController: resideViewController)
            activitiesCoordinator?.delegate = self
            activitiesCoordinator?.start()
        case .rackets:
            racketsCoordinator = RacketsCoordinator(resideViewController: resideViewController)
            racketsCoordinator?.delegate = self
            racketsCoordinator?.start()
        case .stats:
            statsCoordinator = StatsCoordinator(resideViewController: resideViewController)
            statsCoordinator?.delegate = self
            statsCoordinator?.start()
        case .profile:
            profileCoordinator = ProfileCoordinator(resideViewController: resideViewController)
            profileCoordinator?.delegate = self
            profileCoordinator?.start()
        case .settings:
            settingsCoordinator = SettingsCoordinator(resideViewController: resideViewController)
            settingsCoordinator?.delegate = self
            settingsCoordinator?.start()
        case .logout:
            return
        }
    }
    
    // MARK: Coordinator Delegates
    
    func activitiesCoordinatorDidFinish(activitiesCoordinator: ActivitiesCoordinator) {
        self.activitiesCoordinator = nil
    }
    
    func racketsCoordinatorDidFinish(racketsCoordinator: RacketsCoordinator) {
        self.racketsCoordinator = nil
    }
    
    func statsCoordinatorDidFinish(statsCoordinator: StatsCoordinator) {
        self.statsCoordinator = nil
    }
    
    func profileCoordinatorDidFinish(profileCoordinator: ProfileCoordinator) {
        self.profileCoordinator = nil
    }
    
    func settingsCoordinatorDidFinish(settingsCoordinator: SettingsCoordinator) {
        self.settingsCoordinator = nil
    }
    
    
    deinit {
        Log.verbose("+++ Deinit \(self) +++")
    }
}

//
//  AppCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 29/03/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator, LoginCoordinatorDelegate, RESideCoordinatorDelegate {
    
    // MARK: Properties
    
    var coordinators = [String:Coordinator]()
        
    fileprivate weak var window: UIWindow!
    
    var isLoggedIn: Bool {
        return (FirebaseProxy.sharedInstance.currentUser != nil ? true : false)
    }
    
    // MARK: Coordinator
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if isLoggedIn {
            showActivities()
        } else {
            showLogin()
        }
    }
    
    private func showLogin() {
        coordinators["login"] = nil
        
        let loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        coordinators["login"] = loginCoordinator
    }
    
    private func showActivities() {
        coordinators["login"] = nil
        
        let resideCoordinator = RESideCoordinator(window: window)
        resideCoordinator.delegate = self
        resideCoordinator.start()
        coordinators["reside"] = resideCoordinator
    }
    
    // MARK: LoginCoordinatorDelegate
    
    func loginCoordinatorDidFinish(loginCoordinator: LoginCoordinator) {
        showActivities()
    }
    
    // MARK: RESideCoordinatorDelegate
    
    func resideCoordinatorDidFinish(resideCoordinator: RESideCoordinator) {
        
    }
}

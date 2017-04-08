//
//  AppCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 29/03/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow
    var coordinators = [String:Coordinator]()
    
    var isLoggedIn: Bool {
        return (FirebaseProxy.sharedInstance.currentUser != nil ? true : false)
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if isLoggedIn {
            showHome()
        } else {
            showAuthentication()
        }
    }
    
    func showAuthentication() {
        AppDelegate.instance.setRootViewController(Utils.getControllerFromStoryboard("Login"))
        //TO-DO
        //        let authenticationCoordinator = AuthenticationCoordinator(window: window)
        //        coordinators[AUTHENTICATION_KEY] = authenticationCoordinator
        //        authenticationCoordinator.delegate = self
        //        authenticationCoordinator.start()
    }
    
    func showHome() {
        //TO-DO
        AppDelegate.instance.setRootViewController(Utils.getControllerFromStoryboard("Main"))
        //        let listCoordinator = ListCoordinator(window: window)
        //        coordinators[LIST_KEY] = listCoordinator
        //        listCoordinator.delegate = self
        //        listCoordinator.start()
    }
}

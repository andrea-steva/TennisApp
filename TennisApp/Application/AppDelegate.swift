//
//  AppDelegate.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var instance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
        
    var window: UIWindow?
    
    private var mainCoordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let coordinator = AppCoordinator(window: window!)
        coordinator.start()
        window?.makeKeyAndVisible()
        
        mainCoordinator = coordinator
        
        let _ = Logger()
        
        Style.setupNavigationBarStyle()
        Style.setupTextFieldStyle()
        Style.setupSearchBarStyle()

        return true
    }
}

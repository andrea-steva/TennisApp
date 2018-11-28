//
//  AppDelegate.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import LifetimeTracker

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

        #if DEBUG
            LifetimeTracker.setup(onUpdate: LifetimeTrackerDashboardIntegration.alwaysVisible().refreshUI)
        #endif

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
        let handledFacebookLogin = FBSDKApplicationDelegate.sharedInstance().application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String!,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return handledFacebookLogin
    }
}

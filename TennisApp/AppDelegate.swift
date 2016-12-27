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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static func instance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let _ = Logger()
        Services.initialize()
        FIRApp.configure()

        Style.setupNavigationBarStyle()
        Style.setupTextFieldStyle()
        Style.setupSearchBarStyle()

        if LocalStorage().getUser().isEmpty {
            //Load Home
            let rootViewController = Utils.getControllerFromStoryboard("Login")
            self.setRootViewController(rootViewController)

        } else {
            //Load login            
            let rootViewController = Utils.getControllerFromStoryboard("Main")
            self.setRootViewController(rootViewController)
        }

        return true
    }

    func setRootViewController(_ rootViewController: UIViewController) {
        if window?.rootViewController != rootViewController {
            window?.rootViewController = rootViewController
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}

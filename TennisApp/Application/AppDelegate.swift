//
//  AppDelegate.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Firebase
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var mainCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        // swiftlint:disable:next force_unwrapping
        let coordinator = AppCoordinator(window: window!)
        coordinator.start()
        window?.makeKeyAndVisible()

        mainCoordinator = coordinator

        Log.initialize()

        Style.setupNavigationBarStyle()
        Style.setupTextFieldStyle()
        Style.setupSearchBarStyle()

        return true
    }
}

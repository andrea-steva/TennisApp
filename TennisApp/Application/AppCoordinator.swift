//
//  AppCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 29/03/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator,
                            LoginCoordinatorDelegate,
                            ActivitiesCoordinatorDelegate,
                            RacketsCoordinatorDelegate,
                            StatsCoordinatorDelegate,
                            ProfileCoordinatorDelegate,
                            SettingsCoordinatorDelegate {
    
    // MARK: Properties
    
    var coordinators = [String: Coordinator]()
    let localizer = Localizer()

    private let window: UIWindow
    private let tabBarController: UITabBarController
    
    var isLoggedIn: Bool {
        return (FirebaseService.sharedInstance.currentUser != nil ? true : false)
    }

    // MARK: Tab bar item coordinators

    lazy var activitiesCoordinator: ActivitiesCoordinator = ActivitiesCoordinator()
    lazy var racketsCoordinator: RacketsCoordinator = RacketsCoordinator()
    lazy var statsCoordinator: StatsCoordinator = StatsCoordinator()
    lazy var profileCoordinator: ProfileCoordinator = ProfileCoordinator()
    lazy var settingsCoordinator: SettingsCoordinator = SettingsCoordinator()
    
    // MARK: Coordinator
    
    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        if isLoggedIn {
            showActivities()
        } else {
            showLogin()
        }
    }
    
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        coordinators["login"] = loginCoordinator
    }
    
    private func showActivities() {
        window.rootViewController = tabBarController
        configureTabBarController()
    }

    private func configureTabBarController() {
        let activitiesViewController = activitiesCoordinator.start()
        activitiesCoordinator.delegate = self
        activitiesViewController.tabBarItem = UITabBarItem(title: localizer.get(LocalizedString.menu_home),
                                                           image: UIImage(systemName: "house"), tag: 0)

        let racketsViewController = racketsCoordinator.start()
        racketsCoordinator.delegate = self
        racketsViewController.tabBarItem = UITabBarItem(title: localizer.get(LocalizedString.menu_rackets),
                                                        image: UIImage(systemName: "gear"), tag: 1)

        let statsViewController = statsCoordinator.start()
        statsCoordinator.delegate = self
        statsViewController.tabBarItem = UITabBarItem(title: localizer.get(LocalizedString.menu_stats),
                                                      image: UIImage(systemName: "chart.bar.fill"), tag: 2)

        let profileViewController = profileCoordinator.start()
        profileCoordinator.delegate = self
        profileViewController.tabBarItem = UITabBarItem(title: localizer.get(LocalizedString.menu_profile),
                                                        image: UIImage(systemName: "person"), tag: 3)

        let settingsViewController = settingsCoordinator.start()
        settingsCoordinator.delegate = self
        settingsViewController.tabBarItem = UITabBarItem(title: localizer.get(LocalizedString.menu_settings),
                                                         image: UIImage(systemName: "slider.horizontal.3"), tag: 3)

        tabBarController.tabBar.tintColor = Style.Colors.primaryColor
        tabBarController.viewControllers = [activitiesViewController,
                                            racketsViewController,
                                            statsViewController,
                                            profileViewController,
                                            settingsViewController]
    }

    // MARK: LoginCoordinatorDelegate
    
    func loginCoordinatorDidFinish(loginCoordinator: LoginCoordinator) {
        coordinators["login"] = nil
        showActivities()
    }

    // MARK: Coordinator Delegates

    func activitiesCoordinatorDidFinish(activitiesCoordinator: ActivitiesCoordinator) {
    }

    func racketsCoordinatorDidFinish(racketsCoordinator: RacketsCoordinator) {
    }

    func statsCoordinatorDidFinish(statsCoordinator: StatsCoordinator) {
    }

    func profileCoordinatorDidFinish(profileCoordinator: ProfileCoordinator) {
    }

    func settingsCoordinatorDidFinish(settingsCoordinator: SettingsCoordinator) {
    }


    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

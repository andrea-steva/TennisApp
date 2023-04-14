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

    var loginCoordinator: LoginCoordinator?
    let appDIContainer = AppDIContainer()
    let localizer = Localizer()
    let firebaseService: FirebaseServiceType = FirebaseService.shared

    private let window: UIWindow
    private let tabBarController: UITabBarController

    var isLoggedIn: Bool { firebaseService.isLoggedIn() }

    // MARK: Tab bar item coordinators

    lazy var activitiesCoordinator: ActivitiesCoordinator = ActivitiesCoordinator(appDIContainer: appDIContainer)
    lazy var racketsCoordinator: RacketsCoordinator = RacketsCoordinator(appDIContainer: appDIContainer)
    lazy var statsCoordinator: StatsCoordinator = StatsCoordinator(appDIContainer: appDIContainer)
    lazy var profileCoordinator: ProfileCoordinator = ProfileCoordinator(appDIContainer: appDIContainer)
    lazy var settingsCoordinator: SettingsCoordinator = SettingsCoordinator(appDIContainer: appDIContainer)

    // MARK: Coordinator

    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }

    func start() {
        showActivities()
        return

//        if isLoggedIn {
//            showActivities()
//        } else {
//            showLogin()
//        }
    }

    private func showLogin() {
        loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator?.delegate = self
        loginCoordinator?.start()
    }

    private func showActivities() {
        window.rootViewController = tabBarController
        configureTabBarControllers()
    }

    private func configureTabBarControllers() {
        let activitiesViewController = activitiesCoordinator.start()
        activitiesCoordinator.delegate = self
        activitiesViewController.tabBarItem = UITabBarItem(title: localizer.get(TabBarItem.activities.title),
                                                           image: UIImage(systemName: TabBarItem.activities.iconName), tag: 0)

        let racketsViewController = racketsCoordinator.start()
        racketsCoordinator.delegate = self
        racketsViewController.tabBarItem = UITabBarItem(title: localizer.get(TabBarItem.rackets.title),
                                                        image: UIImage(systemName: TabBarItem.rackets.iconName), tag: 1)

        let statsViewController = statsCoordinator.start()
        statsCoordinator.delegate = self
        statsViewController.tabBarItem = UITabBarItem(title: localizer.get(TabBarItem.stats.title),
                                                      image: UIImage(systemName: TabBarItem.stats.iconName), tag: 2)

        let profileViewController = profileCoordinator.start()
        profileCoordinator.delegate = self
        profileViewController.tabBarItem = UITabBarItem(title: localizer.get(TabBarItem.profile.title),
                                                        image: UIImage(systemName: TabBarItem.profile.iconName), tag: 3)

        let settingsViewController = settingsCoordinator.start()
        settingsCoordinator.delegate = self
        settingsViewController.tabBarItem = UITabBarItem(title: localizer.get(TabBarItem.settings.title),
                                                         image: UIImage(systemName: TabBarItem.settings.iconName), tag: 3)

        tabBarController.tabBar.tintColor = Colors.primaryColor
        tabBarController.viewControllers = [activitiesViewController,
                                            racketsViewController,
                                            statsViewController,
                                            profileViewController,
                                            settingsViewController]
    }

    // MARK: LoginCoordinatorDelegate

    func loginCoordinatorDidFinish(loginCoordinator: LoginCoordinator) {
        self.loginCoordinator = nil
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

    func settingsCoordinatorUserLogout(settingsCoordinator: SettingsCoordinator) {
        self.showLogin()
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

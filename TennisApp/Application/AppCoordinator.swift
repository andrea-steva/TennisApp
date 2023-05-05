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
                            SignUpCoordinatorDelegate,
                            ActivitiesCoordinatorDelegate,
                            RacketsCoordinatorDelegate,
                            StatsCoordinatorDelegate,
                            ProfileCoordinatorDelegate,
                            SettingsCoordinatorDelegate {

    // MARK: Properties

    var loginCoordinator: LoginCoordinator?
    var signUpCoordinator: SignUpCoordinator?

    let appDIContainer = AppDIContainer()
    let localizer = Localizer()

    private let window: UIWindow
    private let tabBarController: UITabBarController

    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = true
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()

    // MARK: Tab bar item coordinators

    lazy var activitiesCoordinator: ActivitiesCoordinator = ActivitiesCoordinator(container: appDIContainer.activitiesDIContainer)
    lazy var racketsCoordinator: RacketsCoordinator = RacketsCoordinator(container: (appDIContainer.racketsDIContainer, appDIContainer.stringsDIContainer))
    lazy var statsCoordinator: StatsCoordinator = StatsCoordinator(container: appDIContainer.statsDIContainer)
    lazy var profileCoordinator: ProfileCoordinator = ProfileCoordinator(container: appDIContainer.profileDIContainer)
    lazy var settingsCoordinator: SettingsCoordinator = SettingsCoordinator(container: appDIContainer.settingsDIContainer)

    // MARK: Coordinator

    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }

    func start() {
        DefaultUserPrimaryFetchUseCase(usersRepository:
                                        DefaultUsersRepository(usersLocalStorage: UsersCoreDataStorage())).execute { result in
            switch result {
            case .success(let user):
                Log.info("Show activities for \(user.firstName) \(user.lastName)")
                self.showActivities()
            case .failure:
                Log.error("Main user not found")
                self.showSignUp()
            }
        }
    }

    private func showLogin() {
        window.rootViewController = navigationController
        loginCoordinator = LoginCoordinator(appDIContainer: appDIContainer, navigationController: navigationController)
        loginCoordinator?.delegate = self
        loginCoordinator?.start()
    }

    private func showSignUp() {
        window.rootViewController = navigationController
        signUpCoordinator = SignUpCoordinator(appDIContainer: appDIContainer, navigationController: navigationController)
        signUpCoordinator?.delegate = self
        signUpCoordinator?.start()
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

        // To fix dark mode on tab bar
        if #available(iOS 15, *) {
           let tabBarAppearance = UITabBarAppearance()
            tabBarController.tabBar.standardAppearance = tabBarAppearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
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

    // MARK: SignUpCoordinatorDelegate

    func signUpCoordinatorDidFinish(signUpCoordinator: SignUpCoordinator) {
        self.signUpCoordinator = nil
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
        self.showSignUp()
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

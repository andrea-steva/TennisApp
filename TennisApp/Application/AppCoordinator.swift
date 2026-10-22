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

    private let appDIContainer = AppDIContainer()
    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    private let window: UIWindow
    private let tabBarController: UITabBarController

    private let navigationController: UINavigationController = {
        NavigationControllerBuilder()
            .setNavigationBar(isTranslucent: true)
            .setNavigationBarHidden(true, animated: false)
            .build()
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
        UITabBarItem.customTabBarItemAppearance(font: designLibrary.font.tabBarItemFont.standard)
        UINavigationBar.customNavigationBarAppearance(tintColor: designLibrary.color.text.brandPrimary)

        self.showActivities()
        return

        DefaultUserPrimaryFetchUseCase(usersRepository:
                                        DefaultUsersRepository(usersLocalStorage: UsersCoreDataStorage())).execute { result in

            self.showActivities()
            return

            // FIXME: skip signup, go directly to activities for now
            // switch result {
            // case .success(let user):
            //     Log.info("Show activities for \(user.firstName) \(user.lastName)")
            //     self.showActivities()
            // case .failure:
            //     Log.error("Main user not found")
            //     self.showSignUp()
            // }
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
        let tabBarAppearance = UITabBarAppearance()
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBarController.tabBar.tintColor = designLibrary.color.text.brandPrimary

        let activitiesViewController = activitiesCoordinator.start()
        activitiesCoordinator.delegate = self
        activitiesViewController.tabBarItem = UITabBarItem(title: Localization.TabBar.activities,
                                                           image: UIImage(systemName: designLibrary.symbol.tabBar.activities), tag: 0)

        let racketsViewController = racketsCoordinator.start()
        racketsCoordinator.delegate = self
        racketsViewController.tabBarItem = UITabBarItem(title: Localization.TabBar.rackets,
                                                        image: UIImage(systemName: designLibrary.symbol.tabBar.rackets), tag: 1)

        let statsViewController = statsCoordinator.start()
        statsCoordinator.delegate = self
        statsViewController.tabBarItem = UITabBarItem(title: Localization.TabBar.stats,
                                                      image: UIImage(systemName: designLibrary.symbol.tabBar.stats), tag: 2)

        let profileViewController = profileCoordinator.start()
        profileCoordinator.delegate = self
        profileViewController.tabBarItem = UITabBarItem(title: Localization.TabBar.profile,
                                                        image: UIImage(systemName: designLibrary.symbol.tabBar.profile), tag: 3)

        let settingsViewController = settingsCoordinator.start()
        settingsCoordinator.delegate = self
        settingsViewController.tabBarItem = UITabBarItem(title: Localization.TabBar.settings,
                                                         image: UIImage(systemName: designLibrary.symbol.tabBar.settings), tag: 3)

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

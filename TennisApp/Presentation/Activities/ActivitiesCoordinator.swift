//
//  ActivitiesCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/06/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Parchment
import UIKit

protocol ActivitiesCoordinatorDelegate: AnyObject {
    func activitiesCoordinatorDidFinish(activitiesCoordinator: ActivitiesCoordinator)
}

final class ActivitiesCoordinator: TabBarItemCoordinator {

    // MARK: Properties

    weak var delegate: ActivitiesCoordinatorDelegate?

    private let container: ActivitiesDIContainer
    private let activitiesContainerViewController: ActivitiesContainerViewController
    private let pagingViewController: PagingViewController
    private let navigationController: UINavigationController

    // MARK: Coordinator

    init(container: ActivitiesDIContainer) {
        self.container = container
        self.pagingViewController = PagingViewController()
        self.activitiesContainerViewController = ActivitiesContainerViewController.instantiateViewController()
        self.navigationController = NavigationControllerBuilder(rootViewController: activitiesContainerViewController)
            .setStandardAppearance()
            .setScrollEdgeAppearance()
            .build()
    }

    func start() -> UIViewController {
        self.activitiesContainerViewController.pagingViewController = pagingViewController
        self.pagingViewController.dataSource = self
        return navigationController
    }

    deinit {
        Log.debug("+++ Deinit \(self) +++")
    }
}

extension ActivitiesCoordinator: PagingViewControllerDataSource {

    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        Activities.allCases.count
    }

    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        switch Activities(rawValue: index) {
        case .match:
            return MatchesCoordinator(navigationController: self.navigationController).start()
        case .practice:
            return PracticesCoordinator(navigationController: self.navigationController).start()
        case .workout:
            return WorkoutsCoordinator(navigationController: self.navigationController).start()
        case .none:
            assertionFailure()
            return UIViewController()
        }
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        guard let page = Activities(rawValue: index) else {
            return PagingIndexItem(index: 0, title: "")
        }
        return PagingIndexItem(index: index, title: page.title)
    }
}

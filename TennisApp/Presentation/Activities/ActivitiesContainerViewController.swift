//
//  ActivitiesContainerViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Parchment

final class ActivitiesContainerViewController: BaseViewController, StoryboardInstantiable {

    // MARK: Property

    let pagingViewController = PagingViewController()


    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_home
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPagingViewController()
    }

    private func setupPagingViewController() {
        pagingViewController.dataSource = self
        pagingViewController.select(index: 0)

        pagingViewController.selectedTextColor = Style.Colors.primaryColor
        pagingViewController.indicatorColor = Style.Colors.primaryColor
        pagingViewController.menuInteraction = .swipe
        pagingViewController.indicatorOptions = .visible(height: 5,
                                                         zIndex: Int.max,
                                                         spacing: UIEdgeInsets.zero,
                                                         insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
}

extension ActivitiesContainerViewController: PagingViewControllerDataSource {

    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return 3
    }

    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        ActivityViewController.instantiateViewController()
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        var title = ""
        if index == 0 {
            title = "Matchs"
        }
        if index == 1 {
            title = "Practice"
        }
        if index == 2 {
            title = "Fitness"
        }
        return PagingIndexItem(index: index, title: title)
    }
}

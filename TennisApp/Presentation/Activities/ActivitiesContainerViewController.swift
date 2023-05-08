//
//  ActivitiesContainerViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Parchment
import UIKit

final class ActivitiesContainerViewController: UIViewController, StoryboardInstantiable,
                                               BackgroundBlurrable, Localizable {

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

    // MARK: Properties

    let localizer = Localizer()
    var pagingViewController: PagingViewController!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.menuHome)
        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        setBackgroundBlurEffect()
        setupPagingViewController()
    }

    private func setupPagingViewController() {
        pagingViewController.select(index: 0)

        pagingViewController.selectedTextColor = Colors.primaryColor
        pagingViewController.font = Fonts.get(.light, size: .normal)
        pagingViewController.selectedFont = Fonts.get(.bold, size: .normal)
        pagingViewController.indicatorColor = Colors.primaryColor
        pagingViewController.menuInteraction = .swipe
        pagingViewController.indicatorOptions = .visible(height: 5,
                                                         zIndex: Int.max,
                                                         spacing: UIEdgeInsets.zero,
                                                         insets: UIEdgeInsets.zero)

        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

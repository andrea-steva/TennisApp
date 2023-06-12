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
                                               BackgroundBlurrable {

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

    // MARK: Properties

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    var pagingViewController: PagingViewController!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.image = UIImage(named: designLibrary.miscellaneous.asset.activitiesBackground)
        self.title = Localization.TabBar.activities

        setBackgroundBlurEffect()
        setupPagingViewController()
    }

    private func setupPagingViewController() {
        pagingViewController.select(index: 0)

        pagingViewController.selectedTextColor = designLibrary.color.text.brandPrimary
        pagingViewController.font = designLibrary.font.textNormalSize.light
        pagingViewController.selectedFont = designLibrary.font.textNormalSize.bold
        pagingViewController.indicatorColor = designLibrary.color.text.brandPrimary
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

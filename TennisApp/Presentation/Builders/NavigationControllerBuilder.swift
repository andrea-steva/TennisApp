//
//  NavigationControllerBuilder.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

struct NavigationControllerBuilder {

    private let designLibrary: DesignLibraryProvider = DesignLibrary()
    private var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
    }

    init(rootViewController: UIViewController) {
        self.navigationController = UINavigationController(rootViewController: rootViewController)
    }

    func setNavigationBar(isTranslucent: Bool) -> NavigationControllerBuilder {
        navigationController.navigationBar.isTranslucent = isTranslucent
        return self
    }

    func setNavigationBarHidden(_ hidden: Bool, animated: Bool) -> NavigationControllerBuilder {
        navigationController.setNavigationBarHidden(hidden, animated: animated)
        return self
    }

    func setScrollEdgeAppearance() -> NavigationControllerBuilder {
        navigationController.navigationBar.scrollEdgeAppearance = getUINavigationBarAppearance()
        return self
    }

    func setStandardAppearance() -> NavigationControllerBuilder {
        navigationController.navigationBar.standardAppearance = getUINavigationBarAppearance()
        return self
    }

    func build() -> UINavigationController {
        self.navigationController
    }

    private func getUINavigationBarAppearance() -> UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [ NSAttributedString.Key.font: designLibrary.font.navigationBarFont.standardTitle ]
        navBarAppearance.largeTitleTextAttributes = [ NSAttributedString.Key.font: designLibrary.font.navigationBarFont.largeTitle ]

        let attributes = [NSAttributedString.Key.font: designLibrary.font.buttonFont.standard]
        navBarAppearance.buttonAppearance.normal.titleTextAttributes = attributes
        navBarAppearance.doneButtonAppearance.normal.titleTextAttributes = attributes
        return navBarAppearance
    }
}

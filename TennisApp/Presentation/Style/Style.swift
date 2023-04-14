//
//  Style.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

struct Style {

    private init() {}

    // MARK: Style

    static func setup() {
        Self.setupNavigationBarStyle()
        Self.setupTabBarItemAppearance()
        Self.setupTextFieldStyle()
        Self.setupSearchBarStyle()
    }

    private static func setupNavigationBarStyle() {
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = Colors.lightColor
        appearance.prefersLargeTitles = true
        appearance.isTranslucent = false
    }
    private static func setupTabBarItemAppearance() {
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.get(.regular, size: .small)], for: .highlighted)
        appearance.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.get(.regular, size: .small)], for: .normal)
    }

    private static func setupTextFieldStyle() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = Colors.primaryColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Colors.lightColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = Colors.lightColor
    }

    private static func setupSearchBarStyle() {
        let configuration = UIImage.SymbolConfiguration(scale: .medium)

        // swiftlint:disable:next force_unwrapping
        var serchImage = UIImage(systemName: "magnifyingglass", withConfiguration: configuration)!
        serchImage = serchImage.withTintColor(Colors.lightColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UISearchBar.appearance().setImage(serchImage,
                                          for: UISearchBar.Icon.search,
                                          state: UIControl.State())

        // swiftlint:disable:next force_unwrapping
        var crossCircle = UIImage(systemName: "multiply.circle", withConfiguration: configuration)!
        crossCircle = crossCircle.withTintColor(Colors.lightColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(crossCircle,
                                          for: UISearchBar.Icon.clear,
                                          state: UIControl.State())
    }

    static func getUINavigationBarAppearance() -> UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.font: Fonts.get(.regular, size: .normal)]
        navBarAppearance.titleTextAttributes = [ NSAttributedString.Key.font: Fonts.get(.light, size: .navigationBar) ]
        navBarAppearance.largeTitleTextAttributes = [ NSAttributedString.Key.font: Fonts.get(.light, size: .navigationBarLargeTitle) ]
        navBarAppearance.buttonAppearance.normal.titleTextAttributes = attributes
        navBarAppearance.doneButtonAppearance.normal.titleTextAttributes = attributes
        return navBarAppearance
    }
}

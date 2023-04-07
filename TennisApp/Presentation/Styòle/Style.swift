//
//  Style.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

struct Style {

    // MARK: Style

    static func setupNavigationBarStyle() {
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = Style.Colors.lightColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Style.Colors.lightColor,
                                          NSAttributedString.Key.font: Style.Fonts.get(.light, size: .navigationBar)]
        // appearance.barTintColor = Style.Colors.navigationBarColor
        appearance.shadowImage = UIImage.imageWithColor(UIColor.clear)
        // appearance.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        appearance.isTranslucent = false
    }

    static func setupTextFieldStyle() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = Style.Colors.primaryColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Style.Colors.lightColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = Style.Colors.lightColor
    }

    static func setupSearchBarStyle() {
        let configuration = UIImage.SymbolConfiguration(scale: .medium)

        // swiftlint:disable:next force_unwrapping
        var serchImage = UIImage(systemName: "magnifyingglass", withConfiguration: configuration)!
        serchImage = serchImage.withTintColor(Style.Colors.lightColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UISearchBar.appearance().setImage(serchImage,
                                          for: UISearchBar.Icon.search,
                                          state: UIControl.State())

        // swiftlint:disable:next force_unwrapping
        var crossCircle = UIImage(systemName: "multiply.circle", withConfiguration: configuration)!
        crossCircle = crossCircle.withTintColor(Style.Colors.lightColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(crossCircle,
                                          for: UISearchBar.Icon.clear,
                                          state: UIControl.State())
    }

    static func setup() {
        Colors.setupStyle()
    }

    struct Colors {

        static var primaryColor = UIColor(hexRgba: "EB7116FF")
        static let primaryPressedColor = UIColor(hexRgba: "EB7116FF").withAlphaComponent(0.6)
        static var primaryDarkColor = UIColor(hexRgba: "60800AFF")
        static let primaryDarkPressedColor = primaryDarkColor.withAlphaComponent(0.6)

        static var courtClay = UIColor(hexRgba: "EB7116FF")
        static var courtHardB = UIColor(hexRgba: "2867A5FF")
        static var courtHardG = UIColor(hexRgba: "6B8468FF")
        static var courtHardP = UIColor(hexRgba: "713972FF")
        static var courtGrass = UIColor(hexRgba: "8EA525FF")

        static let lightColor = UIColor.white
        static let darkColor = UIColor(hexRgba: "111111FF")
        static let grayColor = UIColor(hexRgba: "a7a7aaff")
        static let lightGrayColor = UIColor(hexRgba: "F3F3F3ff")

        static let navigationBarColor = UIColor(hexRgba: "F2FB68FF")
        static let errorColor = UIColor(hexRgba: "FF0000FF")
        static let notificationColor = UIColor(hexRgba: "fd3e01ff")
        static let cellBackgroundColor = lightColor
        static let separatorColor = UIColor(hexRgba: "a7a7aaff")

        static func setupStyle() {
        }
    }

    struct Fonts {

        /**
         Get font with font weight and font size

         - parameter type: The font type
         - parameter size: The font size

         - returns: The Font
         */
        static func get(_ type: FontType, size: FontSize) -> UIFont {
            // swiftlint:disable:next force_unwrapping
            UIFont(name: type.rawValue, size: CGFloat(size.get()))!
        }

        /**
         Get font with font weight and custom size based on device type

         - parameter type: The font type
         - parameter size: The font size in CGFloat point

         - returns: The font
         */
        static func get(_ type: FontType, size: CGFloat) -> UIFont {
            // swiftlint:disable:next force_unwrapping
            UIFont(name: type.rawValue, size: scaleSize(size))!
        }

        private static func scaleSize(_ size: CGFloat) -> CGFloat {
            size
        }
    }

    struct Images {
        static let notAvailable = UIImage(named: "not_available")

        static let menuBackground1 = UIImage(named: "menu_background_1")
        static let menuBackground2 = UIImage(named: "menu_background_2")
        static let menuBackground3 = UIImage(named: "menu_background_3")

        static let courtClay = UIImage(named: "court_clay")
        static let courtGrass = UIImage(named: "court_grass")
        static let courtHardB = UIImage(named: "court_hard_b")
        static let courtHardG = UIImage(named: "court_hard_g")
        static let courtHardP = UIImage(named: "court_hard_p")
    }
}

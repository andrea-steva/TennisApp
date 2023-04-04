//
//  Style.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

// MARK: FontType

enum Theme: String {
    case normal = "default"
    case clay = "clay"
    case hard = "hard"
    case grass = "grass"
}

enum FontType: String {
    case bold = "Lato-Bold"
    case semibold = "Lato-Semibold"
    case regular = "Lato-Regular"
    case light = "Lato-Light"
    case thin = "Lato-Thin"
    
    static func fromIndex(_ index: Int) -> FontType? {
        switch index {
        case 0:
            return .bold
        case 1:
            return .semibold
        case 2:
            return .regular
        case 3:
            return .light
        case 4:
            return .thin
        default:
            return nil
        }
    }
    
    func toIndex() -> Int {
        switch self {
        case .bold:
            return 0
        case .semibold:
            return 1
        case .regular:
            return 2
        case .light:
            return 3
        case .thin:
            return 4
        }
    }
    
    static var count: Int {
        var max: Int = 0
        while let _ = FontType.fromIndex(max) {
            max += 1
        }
        return max
    }
    
}

// MARK: FontSize

enum FontSize {
    case extraSmall
    case small
    case normal
    case large
    case extraLarge
    case navigationBar
    
    /**
     Get font size value based on FontSize and DeviceType
     
     - returns: The font size
     */
    func get() -> CGFloat {
        
        let extraSmallSize: CGFloat = 11
        let smallSize: CGFloat = 13
        let normalSize: CGFloat = 15
        let largeSize: CGFloat = 18
        let extraLargeSize: CGFloat = 22
        let navigationBarSize: CGFloat = 26

        //Default value normaSize
        var standardSize: CGFloat = normalSize
        
        switch self {
        case .extraSmall:
            standardSize = extraSmallSize
        case .small:
            standardSize = smallSize
        case .normal:
            standardSize = normalSize
        case .large:
            standardSize = largeSize
        case .extraLarge:
            standardSize = extraLargeSize
        case .navigationBar:
            standardSize = navigationBarSize
        }
        
        return standardSize
    }
    
}

// MARK: Style

struct Style {
    
    // MARK: Style
    
    static func setupNavigationBarStyle() {
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = Style.Colors.lightColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Style.Colors.lightColor, NSAttributedString.Key.font: Style.Fonts.get(.light, size: .navigationBar)]
        //appearance.barTintColor = Style.Colors.navigationBarColor
        appearance.shadowImage = UIImage.imageWithColor(UIColor.clear)
        //appearance.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        appearance.isTranslucent = false
    }
    
    static func setupTextFieldStyle() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = Style.Colors.primaryColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Style.Colors.lightColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = Style.Colors.lightColor
    }
    
    static func setupSearchBarStyle() {
        let configuration = UIImage.SymbolConfiguration(scale: .medium)

        var serchImage = UIImage(systemName: "magnifyingglass", withConfiguration: configuration)!
        serchImage = serchImage.withTintColor(Style.Colors.lightColor, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UISearchBar.appearance().setImage(serchImage,
                                          for: UISearchBar.Icon.search,
                                          state: UIControl.State())
        var crossCircle = UIImage(systemName: "multiply.circle", withConfiguration: configuration)!
        serchImage = serchImage.withTintColor(Style.Colors.lightColor, renderingMode: .alwaysOriginal)

        UISearchBar.appearance().setImage(crossCircle,
                                          for: UISearchBar.Icon.clear,
                                          state: UIControl.State())
    }
    
    static func setup() {
        Colors.setupStyle()
    }
    
    /**
     *  This struct defines the colors used by the application
     */
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
            return UIFont(name: type.rawValue, size: CGFloat(size.get()))!
        }
        
        /**
         Get font with font weight and custom size based on device type
         
         - parameter type: The font type
         - parameter size: The font size in CGFloat point
         
         - returns: The font
         */
        static func get(_ type: FontType, size: CGFloat) -> UIFont {
            return UIFont(name: type.rawValue, size: scaleSize(size))!
        }
        
        static fileprivate func scaleSize(_ size: CGFloat) -> CGFloat {
            return size
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

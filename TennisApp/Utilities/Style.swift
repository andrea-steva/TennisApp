//
//  Style.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import FontAwesome_swift

//MARK: FontType

enum Theme : String {
    case Default = "default"
    case Clay = "clay"
    case Hard = "hard"
    case Grass = "grass"
}

enum FontType: String {
    case Bold = "Lato-Bold"
    case Semibold = "Lato-Semibold"
    case Regular = "Lato-Regular"
    case Light = "Lato-Light"
    case Thin = "Lato-Thin"
    
    static func fromIndex(index: Int) -> FontType? {
        switch index {
        case 0:
            return .Bold
        case 1:
            return .Semibold
        case 2:
            return .Regular
        case 3:
            return .Light
        case 4:
            return .Thin
        default:
            return nil
        }
    }
    
    func toIndex() -> Int {
        switch self {
        case .Bold:
            return 0
        case .Semibold:
            return 1
        case .Regular:
            return 2
        case .Light:
            return 3
        case .Thin:
            return 4
        }
    }
    
    static var count: Int {
        var max: Int = 0
        while let _ =  FontType.fromIndex(max) {
            max += 1
        }
        return max
    }
    
}

//MARK: FontSize

enum FontSize {
    case ExtraSmall
    case Small
    case Normal
    case Large
    case ExtraLarge
    case NavigationBar
    
    /**
     Get font size value based on FontSize and DeviceType
     
     - returns: The font size
     */
    func get() -> CGFloat {
        
        //Standard font size (iPhone 5S and previous)
        let extraSmallSize : CGFloat = 11;
        let smallSize : CGFloat = 13;
        let normalSize : CGFloat = 15;
        let largeSize : CGFloat = 18;
        let extraLargeSize : CGFloat = 22;
        let navigationBarSize : CGFloat = 26;
        
        let additionIphone6Plus : CGFloat = 3
        let additionIphone6 : CGFloat = 1
        
        //Default value normaSize
        var standardSize : CGFloat = normalSize
        
        switch self {
        case .ExtraSmall:
            standardSize = extraSmallSize
        case .Small:
            standardSize = smallSize
        case .Normal:
            standardSize = normalSize
        case .Large:
            standardSize = largeSize
        case .ExtraLarge:
            standardSize = extraLargeSize
        case .NavigationBar:
            standardSize = navigationBarSize
        }

        
        if UIDevice.isIphone6Plus {
            return standardSize + additionIphone6Plus
        } else if UIDevice.isIphone6 {
            return standardSize + additionIphone6
        } else {
            return standardSize
        }
    }
    
}

//MARK: Style

struct Style {
    
    //MARK: Style
    
    static func setupNavigationBarStyle() {
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = Style.Colors.lightColor
        appearance.titleTextAttributes = [NSForegroundColorAttributeName : Style.Colors.lightColor, NSFontAttributeName : Style.Fonts.get(.Light, size: .NavigationBar)]
        //appearance.barTintColor = Style.Colors.navigationBarColor
        appearance.shadowImage = UIImage.imageWithColor(UIColor.clearColor())
        //appearance.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        appearance.translucent = false
    }
    
    static func setupTextFieldStyle() {
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).backgroundColor = Style.Colors.primaryColor
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = Style.Colors.lightColor
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = Style.Colors.lightColor
    }
    
    static func setupSearchBarStyle() {
        UISearchBar.appearance().setBackgroundImage(UIImage(), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        UISearchBar.appearance().setImage(UIImage.fontAwesomeIconWithName(FontAwesome.Search, textColor: Style.Colors.lightColor, size: CGSizeMake(32, 32)), forSearchBarIcon: UISearchBarIcon.Search, state: .Normal)
        UISearchBar.appearance().setImage(UIImage.fontAwesomeIconWithName(FontAwesome.TimesCircle, textColor: Style.Colors.lightColor, size: CGSizeMake(20, 20)), forSearchBarIcon: UISearchBarIcon.Clear, state: .Normal)
    }
    
    static func setup() {
        Colors.setupStyle()
    }
    
    static let MARGIN : CGFloat = 20
    
    /**
     *  This struct defines the colors used by the application
     */
    struct Colors {
        
        static var primaryColor = UIColor(hexRgba: "7FA311FF")
        static let primaryPressedColor = primaryColor.colorWithAlphaComponent(0.8)
        static var primaryDarkColor = UIColor(hexRgba: "60800AFF")
        static let primaryDarkPressedColor = primaryDarkColor.colorWithAlphaComponent(0.8)
        
        static var courtClay = UIColor(hexRgba: "EB7116FF")
        static var courtHardB = UIColor(hexRgba: "2867A5FF")
        static var courtHardG = UIColor(hexRgba: "6B8468FF")
        static var courtGrass = UIColor(hexRgba: "#8EA525FF")
        
        static let lightColor = UIColor.whiteColor()
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
        static let baseName = "OpenSans"
        
        /**
         Get font with font weight and font size
         
         - parameter type: The font type
         - parameter size: The font size
         
         - returns: The Font
         */
        static func get(type: FontType, size: FontSize) -> UIFont {
            return UIFont(name: type.rawValue, size: CGFloat(size.get()))!
        }
        
        /**
         Get font with font weight and custom size based on device type
         
         - parameter type: The font type
         - parameter size: The font size in CGFloat point
         
         - returns: The font
         */
        static func get(type: FontType, size: CGFloat) -> UIFont {
            return UIFont(name: type.rawValue, size: scaleSize(size))!
        }
        
        static private func scaleSize(size : CGFloat) -> CGFloat {
            
            if UIDevice.isIphone6Plus {
                return size + 3
            }
            else if UIDevice.isIphone6 {
                return size + 1
            }
            return size
        }
    }
    
    struct Images {
        static let notAvailable =  UIImage(named: "not_available")
        
        static let menuBackground1 = UIImage(named: "menu_background_1")
        static let menuBackground2 = UIImage(named: "menu_background_2")
        static let menuBackground3 = UIImage(named: "menu_background_3")
        
        static let courtClay =  UIImage(named: "court_clay")
        static let courtGrass =  UIImage(named: "court_grass")
        static let courtHardB =  UIImage(named: "court_hard_b")
        static let courtHardG =  UIImage(named: "court_hard_g")
    }
}
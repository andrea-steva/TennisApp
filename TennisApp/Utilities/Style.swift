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
    case BOLD = "Lato-Bold"
    case SEMIBOLD = "Lato-Semibold"
    case REGULAR = "Lato-Regular"
    case LIGHT = "Lato-Light"
    case THIN = "Lato-Thin"
    
    static func fromIndex(index: Int) -> FontType? {
        switch index {
        case 0:
            return .BOLD
        case 1:
            return .SEMIBOLD
        case 2:
            return .REGULAR
        case 3:
            return .LIGHT
        case 4:
            return .THIN
        default:
            return nil
        }
    }
    
    func toIndex() -> Int {
        switch self {
        case .BOLD:
            return 0
        case .SEMIBOLD:
            return 1
        case .REGULAR:
            return 2
        case .LIGHT:
            return 3
        case .THIN:
            return 4
        }
    }
    
    static var count: Int {
        var max: Int = 0
        while let _ =  FontType.fromIndex(++max) {}
        return max
    }
    
}

//MARK: FontSize

enum FontSize {
    case EXTRASMALL
    case SMALL
    case NORMAL
    case LARGE
    case EXTRALARGE
    
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
        
        let additionIphone6Plus : CGFloat = 3
        let additionIphone6 : CGFloat = 1
        
        //Default value normaSize
        var standardSize : CGFloat = normalSize
        
        switch self {
        case .EXTRASMALL:
            standardSize = extraSmallSize
        case .SMALL:
            standardSize = smallSize
        case .NORMAL:
            standardSize = normalSize
        case .LARGE:
            standardSize = largeSize
        case .EXTRALARGE:
            standardSize = extraLargeSize
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
        appearance.tintColor = Style.Colors.navigationBarColor
        appearance.titleTextAttributes = [NSForegroundColorAttributeName : Style.Colors.darkColor, NSFontAttributeName : Style.Fonts.get(.LIGHT, size: .EXTRALARGE)]
        appearance.barTintColor = Style.Colors.navigationBarColor
        appearance.shadowImage = UIImage.imageWithColor(Style.Colors.grayColor)
        appearance.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
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
        static var courtHard = UIColor(hexRgba: "#2867A5FF")
        static var courtGrass = UIColor(hexRgba: "#8EA525FF")
        
        static let lightColor = UIColor.whiteColor()
        static let darkColor = UIColor(hexRgba: "111111FF")
        static let grayColor = UIColor(hexRgba: "a7a7aaff")
        static let lightGrayColor = UIColor(hexRgba: "F3F3F3ff")
        
        static let navigationBarColor = UIColor(hexRgba: "#2867A5FF")
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
    }
}
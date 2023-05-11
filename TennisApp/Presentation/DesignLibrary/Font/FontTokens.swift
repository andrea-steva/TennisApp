//
//  FontTokens.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 10/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol FontTokensProvider {
    var textNormalSize: TextNormalSizeFontProvider { get }
    var formsFont: FormsFontProvider { get }
    var buttonFont: ButtonFontProvider { get }
    var tabBarItemFont: TabBarItemFontProvider { get }
    var navigationBarFont: NavigationBarFontProvider { get }
}

struct FontTokens: FontTokensProvider {
    var textNormalSize: TextNormalSizeFontProvider = TextNormalSizeFont()
    let formsFont: FormsFontProvider = FormsFont()
    let buttonFont: ButtonFontProvider = ButtonFont()
    let tabBarItemFont: TabBarItemFontProvider = TabBarItemFont()
    let navigationBarFont: NavigationBarFontProvider = NavigationBarFont()
}

// MARK: Text

protocol TextNormalSizeFontProvider {
    var regular: UIFont { get }
    var bold: UIFont { get }
    var light: UIFont { get }
}

struct TextNormalSizeFont: TextNormalSizeFontProvider {
    let regular = UIFont.custom(.regular, size: .normal)
    let bold = UIFont.custom(.bold, size: .normal)
    let light = UIFont.custom(.light, size: .normal)
}

// MARK: Forms

protocol FormsFontProvider {
    var title: UIFont { get }
    var body: UIFont { get }
}

struct FormsFont: FormsFontProvider {
    let title = UIFont.custom(.regular, size: .extraLarge)
    let body = UIFont.custom(.regular, size: .normal)
}

// MARK: Button

protocol ButtonFontProvider {
    var standard: UIFont { get }
}

struct ButtonFont: ButtonFontProvider {
    let standard = UIFont.custom(.regular, size: .normal)
}

// MARK: TabBarItem

protocol TabBarItemFontProvider {
    var standard: UIFont { get }
}

struct TabBarItemFont: TabBarItemFontProvider {
    let standard = UIFont.custom(.regular, size: .normal)
}

// MARK: NavigationBar

protocol NavigationBarFontProvider {
    var buttons: UIFont { get }
    var standardTitle: UIFont { get }
    var largeTitle: UIFont { get }
}

struct NavigationBarFont: NavigationBarFontProvider {
    let buttons = UIFont.custom(.regular, size: .normal)
    let standardTitle = UIFont.custom(.light, size: .navigationBar)
    let largeTitle = UIFont.custom(.light, size: .navigationBarLargeTitle)
}

//
//  Fonts.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

enum FontType: String, CaseIterable {
    case bold = "Lato-Bold"
    case regular = "Lato-Regular"
    case light = "Lato-Light"
}

enum FontSize: CGFloat {
    case small = 13
    case normal = 15
    case large = 18
    case extraLarge = 22
    case navigationBar = 26
    case navigationBarLargeTitle = 35
}

extension UIFont {

    static func custom(_ type: FontType, size: FontSize) -> UIFont {
        UIFont(name: type.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }
}

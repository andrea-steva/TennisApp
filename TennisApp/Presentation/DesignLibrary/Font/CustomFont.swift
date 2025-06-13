//
//  Fonts.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

enum FontType: String, CaseIterable {
    case bold
    case regular
    case light
}

/// https://developer.apple.com/design/human-interface-guidelines/typography#iOS-iPadOS-Dynamic-Type-sizes
enum FontSize: CGFloat {
    case subtitle = 13
    case body = 17
    case headline = 24
    case headline2 = 20
    case navigationBar = 26
    case navigationBarLargeTitle = 34
}

extension UIFont {

    enum Typography {
        case body
        case subtitle
        case headline1
        case headline2
        case navigationBar
        case navigationBarLargeTitle
    }

    static func custom(_ type: FontType, size: FontSize) -> UIFont {
        UIFont.rounded(ofSize: size.rawValue, weight: .regular)
    }

    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}

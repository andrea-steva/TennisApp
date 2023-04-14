//
//  Fonts.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

struct Fonts {

    /// Get font with font weight and font size
    /// - Parameters:
    ///   - type: The font type
    ///   - size: The font size
    /// - Returns: The Font
    static func get(_ type: FontType, size: FontSize) -> UIFont {
        // swiftlint:disable:next force_unwrapping
        UIFont(name: type.rawValue, size: CGFloat(size.get()))!
    }

    /// Get font with font weight and custom size based on device type
    /// - Parameters:
    ///   - type: The font type
    ///   - size: The font size in CGFloat point
    /// - Returns: The font
    static func get(_ type: FontType, size: CGFloat) -> UIFont {
        // swiftlint:disable:next force_unwrapping
        UIFont(name: type.rawValue, size: scaleSize(size))!
    }

    private static func scaleSize(_ size: CGFloat) -> CGFloat {
        size
    }
}

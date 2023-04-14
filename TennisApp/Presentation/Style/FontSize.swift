//
//  FontSize.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum FontSize {
    case extraSmall
    case small
    case normal
    case large
    case extraLarge
    case navigationBar
    case navigationBarLargeTitle

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
        let navigationBarLargeTitleSize: CGFloat = 35

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
        case .navigationBarLargeTitle:
            standardSize = navigationBarLargeTitleSize
        }

        return standardSize
    }
}

//
//  FontType.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum FontType: String, CaseIterable {
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
}

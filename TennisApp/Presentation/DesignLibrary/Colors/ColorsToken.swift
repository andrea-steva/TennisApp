//
//  ColorsToken.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 10/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol ColorTokensProvider {
    var text: TextColorsProvider { get }
    var background: BackgroundColorsProvider { get }
}

struct ColorTokens: ColorTokensProvider {
    let text: TextColorsProvider = TextColors()
    let background: BackgroundColorsProvider = BackgroundColors()
}

// MARK: Text

protocol TextColorsProvider {
    var standard: UIColor { get }
    var brandPrimary: UIColor { get }
    var navigationBarTint: UIColor { get }
    var light: UIColor { get }
}

struct TextColors: TextColorsProvider {
    let standard: UIColor
    let brandPrimary: UIColor
    let navigationBarTint: UIColor
    let light: UIColor

    init(baseColors: BaseColorsProvider = BaseColors()) {
        self.standard = baseColors.dark
        self.brandPrimary = baseColors.brandPrimary
        self.navigationBarTint = baseColors.brandPrimary
        self.light = baseColors.light
    }
}

// MARK: Background

protocol BackgroundColorsProvider {
    var buttonPrimary: UIColor { get }
    var buttonPressed: UIColor { get }
    var buttonDisabled: UIColor { get }
    var editAction: UIColor { get }
}

struct BackgroundColors: BackgroundColorsProvider {
    let buttonPrimary: UIColor
    let buttonPressed: UIColor
    let buttonDisabled: UIColor
    let editAction: UIColor

    init(baseColors: BaseColorsProvider = BaseColors()) {
        self.buttonPrimary = baseColors.brandPrimary
        self.buttonPressed = baseColors.brandPrimary.withAlphaComponent(0.6)
        self.buttonDisabled = baseColors.brandPrimary.withAlphaComponent(0.6)
        self.editAction = baseColors.courtHardPurple
    }
}

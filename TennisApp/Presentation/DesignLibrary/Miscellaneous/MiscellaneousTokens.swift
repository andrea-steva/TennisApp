//
//  MiscellaneousTokens.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 10/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol MiscellaneousTokensProvider {
    var cornerRadius: CornerRadiusesProvider { get }
    var opacity: OpacitiesProvider { get }
    var asset: AssetNamesProvider { get }
}

struct MiscellaneousTokens: MiscellaneousTokensProvider {
    let cornerRadius: CornerRadiusesProvider = CornerRadiuses()
    let opacity: OpacitiesProvider = Opacities()
    let asset: AssetNamesProvider = AssetNames()
}

// MARK: CornerRadius

protocol CornerRadiusesProvider {
    var button: Double { get }
}

struct CornerRadiuses: CornerRadiusesProvider {
    let button: Double = 5.0
}

// MARK: Opacity

protocol OpacitiesProvider {
    var button: Double { get }
}

struct Opacities: OpacitiesProvider {
    let button: Double = 0.6
}

// MARK: Asset

protocol AssetNamesProvider {
    var loginBackground: String { get }
    var signUpBackground: String { get }
    var activitiesBackground: String { get }
    var racketsBackground: String { get }
    var stringsBackground: String { get }
    var statsBackground: String { get }
    var profileBackground: String { get }
    var settingsBackground: String { get }
}

struct AssetNames: AssetNamesProvider {
    let loginBackground = "courtClayDimitrov"
    let signUpBackground = "courtClayDimitrov"
    let activitiesBackground = "courtClay"
    let racketsBackground = "courtBlue"
    let stringsBackground = "courtBlue"
    let statsBackground = "courtGrass"
    let profileBackground = "courtGreen"
    let settingsBackground = "courtPurple"
}

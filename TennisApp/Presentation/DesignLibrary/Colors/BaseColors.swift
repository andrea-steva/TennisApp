//
//  BaseColors.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 10/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol BaseColorsProvider {
    var brandPrimary: UIColor { get }
    var light: UIColor { get }
    var dark: UIColor { get }
    var white: UIColor { get }
    var black: UIColor { get }

    var courtClay: UIColor { get }
    var courtHardBlue: UIColor { get }
    var courtHardGreen: UIColor { get }
    var courtHardPurple: UIColor { get }
    var courtGrass: UIColor { get }
}

struct BaseColors: BaseColorsProvider {
    let brandPrimary = UIColor(resource: .primary)
    let light = UIColor.white
    let dark = UIColor.black
    let white = UIColor.white
    let black = UIColor.black

    var courtClay = UIColor(resource: .courtClay)
    var courtHardBlue = UIColor(resource: .courtHardBlue)
    var courtHardGreen = UIColor(resource: .courtHardGreen)
    var courtHardPurple = UIColor(resource: .courtHardPurple)
    var courtGrass = UIColor(resource: .courtGrass)
}

//
//  DesignLibrary.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 10/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

struct DesignLibrary: DesignLibraryProvider {
    let color: ColorTokensProvider = ColorTokens()
    let font: FontTokensProvider = FontTokens()
    let symbol: SymbolTokensProvider = SymbolTokens()
    let miscellaneous: MiscellaneousTokensProvider = MiscellaneousTokens()
}

protocol DesignLibraryProvider {
    var color: ColorTokensProvider { get }
    var font: FontTokensProvider { get }
    var symbol: SymbolTokensProvider { get }
    var miscellaneous: MiscellaneousTokensProvider { get }
}

//
//  String+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

extension String {
    var capitalizeFirstLetter: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}

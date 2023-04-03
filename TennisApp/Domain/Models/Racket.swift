//
//  Racket.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// The racket domain model
struct Racket {
    var racketId: String
    var manufacter: String
    var model: String
    var weight: String
    var gripSize: GripSize
    var image: Data?
    var purchaseDate: Date?

    // Add relationships
}

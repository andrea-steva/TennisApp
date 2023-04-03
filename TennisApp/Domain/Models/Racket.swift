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
    var identifier: String
    var manufacter: String
    var model: String
    var weight: Float
    var gripSize: GripSize
    var image: Data?
    var purchaseDate: Date?

    // Add relationships
}

extension Racket {
    init(form: [String: Any?]) {
        self.identifier = UUID().uuidString
        self.manufacter = ""
        self.model = ""
        self.weight = 0.0
        self.gripSize = .one
        self.image = nil
        self.purchaseDate = Date()
    }
}

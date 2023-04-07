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
    var weight: Int32
    var gripSize: GripSize
    var image: Data?
    var purchaseDate: Date?

    // Add relationships
}

extension Racket {

    init(form: [String: Any?]) {
        self.identifier = UUID().uuidString
        self.manufacter = form["manufacter"] as? String ?? ""
        self.model = form["model"] as? String ?? ""
        self.weight = Int32(form["weight"] as? String ?? "0") ?? 0
        self.gripSize = GripSize(rawValue: form["weight"] as? String ?? "1") ?? .one
        self.image = nil
        self.purchaseDate = form["purchaseDate"] as? Date ?? Date()
    }

    init(racket: Racket, form: [String: Any?]) {
        self.identifier = racket.identifier
        self.manufacter = form["manufacter"] as? String ?? ""
        self.model = form["model"] as? String ?? ""
        self.weight = Int32(form["weight"] as? String ?? "0") ?? 0
        self.gripSize = GripSize(rawValue: form["weight"] as? String ?? "1") ?? .one
        self.image = nil
        self.purchaseDate = form["purchaseDate"] as? Date ?? Date()
    }
}

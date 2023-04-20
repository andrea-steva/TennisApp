//
//  Racket.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

/// The racket domain model
struct Racket {
    var identifier: String
    var manufacter: String
    var model: String
    var weight: Int32
    var gripSize: GripSize
    var image: Data?
    var purchaseDate: Date?
    var sport: Sport
    var price: Double

    var strings: [Strings] = []
}

extension Racket {

    init(racket: Racket?, form: [String: Any?]) {
        self.identifier = racket?.identifier ?? UUID().uuidString
        self.manufacter = form["manufacter"] as? String ?? ""
        self.model = form["model"] as? String ?? ""
        self.weight = Int32(form["weight"] as? Int ?? 0)
        self.gripSize = GripSize(rawValue: form["gripSize"] as? String ?? "1") ?? .one
        self.image = (form["image"] as? UIImage)?.jpegData(compressionQuality: 80)
        self.purchaseDate = form["purchaseDate"] as? Date ?? Date()
        self.sport = Sport(rawValue: form["sport"] as? String ?? "Tennis") ?? .tennis
        self.price = form["price"] as? Double ?? 0
    }
}

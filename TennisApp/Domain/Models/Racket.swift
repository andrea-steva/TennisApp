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
    var imageData: Data?
    var purchaseDate: Date?
    var sport: Sport
    var price: Double

    var strings: [Strings] = []
}

extension Racket {

    init(racket: Racket?, formData: [String: Any?]) {
        self.identifier = racket?.identifier ?? UUID().uuidString
        self.manufacter = formData["manufacter"] as? String ?? ""
        self.model = formData["model"] as? String ?? ""
        self.weight = Int32(formData["weight"] as? Int ?? 0)
        self.gripSize = GripSize(rawValue: formData["gripSize"] as? String ?? "") ?? .one
        self.imageData = (formData["image"] as? UIImage)?.jpegData(compressionQuality: 80)
        self.purchaseDate = formData["purchaseDate"] as? Date
        self.sport = Sport(rawValue: formData["sport"] as? String ?? "") ?? .tennis
        self.price = formData["price"] as? Double ?? 0
    }
}

extension Racket {

    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}

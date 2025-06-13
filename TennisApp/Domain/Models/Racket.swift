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
    let identifier: String
    let manufacter: String
    let model: String
    let weight: Int32
    let gripSize: GripSize
    let imageData: Data?
    let purchaseDate: Date?
    let sport: Sport
    let price: Double
    let inUse: Bool

    let strings: [Strings]
    let user: User?
}

extension Racket {

    init(racket: Racket?, formData: [String: Any?]) {
        self.identifier = racket?.identifier ?? UUID().uuidString
        self.manufacter = formData[RacketForm.Keys.manufacter] as? String ?? ""
        self.model = formData[RacketForm.Keys.model] as? String ?? ""
        self.weight = Int32(formData[RacketForm.Keys.weight] as? Int ?? 0)
        self.gripSize = GripSize(rawValue: formData[RacketForm.Keys.gripSize] as? String ?? "") ?? .one
        self.imageData = (formData[RacketForm.Keys.image] as? UIImage)?.jpegData(compressionQuality: 50)
        self.purchaseDate = formData[RacketForm.Keys.purchaseDate] as? Date
        self.sport = Sport(rawValue: formData[RacketForm.Keys.sport] as? String ?? "") ?? .tennis
        self.price = formData[RacketForm.Keys.price] as? Double ?? 0
        self.inUse = formData[RacketForm.Keys.inUse] as? Bool ?? false
        self.strings = []
        self.user = nil
    }
}

extension Racket {

    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}

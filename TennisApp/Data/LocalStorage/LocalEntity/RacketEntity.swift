//
//  RacketEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData
import Foundation

// MARK: - Mappings to domain

extension RacketEntity {

    func toDomain() -> Racket {
        Racket(identifier: self.identifier ?? "",
               manufacter: self.manufacter ?? "",
               model: self.model ?? "",
               weight: self.weight,
               gripSize: GripSize(rawValue: self.gripSize ?? "") ?? GripSize.one,
               imageData: self.imageData,
               purchaseDate: self.purchaseDate,
               sport: Sport(rawValue: self.sport ?? "") ?? Sport.tennis,
               price: self.price,
               inUse: self.inUse,
               strings: self.strings?.allObjects.compactMap { ($0 as? StringsEntity)?.toDomain() } ?? [])
    }
}

extension RacketEntity {
    convenience init(racket: Racket, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = racket.identifier
        manufacter = racket.manufacter
        model = racket.model
        weight = racket.weight
        gripSize = racket.gripSize.rawValue
        imageData = racket.imageData
        purchaseDate = racket.purchaseDate
        sport = racket.sport.rawValue
        price = racket.price
        inUse = racket.inUse
    }
}

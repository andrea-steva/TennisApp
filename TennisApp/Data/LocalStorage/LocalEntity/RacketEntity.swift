//
//  RacketEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData
import Foundation

//    // MARK: Relationship
//
//    // let user = LinkingObjects(fromType: UserEntity.self, property: "rackets")
//    var strings = List<StringsEntity>()
//

// MARK: - Mappings to domain

extension RacketEntity {

    func toDomain() -> Racket {
        Racket(identifier: self.identifier ?? "",
               manufacter: self.manufacter ?? "",
               model: self.model ?? "",
               weight: self.weight,
               gripSize: GripSize(rawValue: self.gripSize ?? "") ?? GripSize.one,
               image: nil,
               purchaseDate: Date())
    }
}

extension RacketEntity {
    convenience init(racket: Racket, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = racket.identifier
        model = racket.model
        weight = racket.weight
        gripSize = racket.gripSize.rawValue
        image = racket.image
        purchaseDate = racket.purchaseDate
    }
}

//
//  StringsEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData

// MARK: Relationship

// let racket = LinkingObjects(fromType: RacketEntity.self, property: "strings")

// MARK: - Mappings to domain

extension StringsEntity {

    func toDomain() -> Strings {
        Strings(identifier: self.identifier ?? "",
                manufacter: self.manufacter ?? "",
                model: self.model ?? "",
                gauge: self.gauge ?? "",
                duration: self.duration,
                tension: self.tension,
                price: self.price,
                inUse: self.inUse)
    }
}

extension StringsEntity {
    convenience init(string: Strings, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = string.identifier
        model = string.model
        manufacter = string.manufacter
        price = string.price
        gauge = string.gauge
        duration = string.duration
        tension = string.tension
        inUse = string.inUse
    }
}

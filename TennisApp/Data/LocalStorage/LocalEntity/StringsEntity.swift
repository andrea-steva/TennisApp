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
                price: self.price ?? "",
                gauge: self.gauge ?? "",
                duration: self.duration,
                tension: self.tension)
    }
}

extension StringsEntity {
    convenience init(strings: Strings, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = strings.identifier
        model = strings.model
        manufacter = strings.manufacter
        price = strings.price
        gauge = strings.gauge
        duration = strings.duration
        tension = strings.tension
    }
}

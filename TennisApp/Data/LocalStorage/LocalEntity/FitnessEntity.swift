//
//  Fitness.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData

extension FitnessEntity {

    func toDomain() -> Fitness {
        Fitness(identifier: self.identifier ?? "",
                name: self.name ?? "",
                notes: self.notes ?? "",
                place: self.place ?? "",
                timeSpent: self.timeSpent,
                date: self.date,
                fitnessType: Fitness.FitnessType(rawValue: fitnessType ?? "") ?? .other,
                user: nil)
    }
}

extension FitnessEntity {
    convenience init(fitness: Fitness, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = fitness.identifier
        name = fitness.name
        notes = fitness.notes
        place = fitness.place
        date = fitness.date
        timeSpent = fitness.timeSpent
        fitnessType = fitness.fitnessType.rawValue
    }
}

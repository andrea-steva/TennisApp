//
//  PracticeEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData

    // MARK: Relationship

    // let user = LinkingObjects(fromType: UserEntity.self, property: "practices")

extension PracticeEntity {

    func toDomain() -> Practice {
        Practice(identifier: self.identifier ?? "",
                 description: self.title ?? "",
                 notes: self.notes ?? "",
                 place: self.place ?? "",
                 date: self.date,
                 timeSpent: self.timeSpent,
                 practiceType: Practice.PracticeType(rawValue: practiceType ?? "") ?? .forehand,
                 user: nil)
    }
}

extension PracticeEntity {
    convenience init(practice: Practice, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = practice.identifier
        title = practice.description
        notes = practice.notes
        place = practice.place
        date = practice.date
        timeSpent = practice.timeSpent
        practiceType = practice.practiceType.rawValue
    }
}

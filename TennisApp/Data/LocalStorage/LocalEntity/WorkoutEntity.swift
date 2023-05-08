//
//  Fitness.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData

extension WorkoutEntity {

    func toDomain() -> Workout {
        Workout(identifier: self.identifier ?? "",
                name: self.name ?? "",
                notes: self.notes ?? "",
                place: self.place ?? "",
                timeSpent: self.timeSpent,
                date: self.date,
                workoutType: Workout.WorkoutType(rawValue: workoutType ?? "") ?? .other,
                user: nil)
    }
}

extension WorkoutEntity {
    convenience init(workout: Workout, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = workout.identifier
        name = workout.name
        notes = workout.notes
        place = workout.place
        date = workout.date
        timeSpent = workout.timeSpent
        workoutType = workout.workoutType.rawValue
    }
}

//
//  Fitness.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class Fitness: Object, FitnessProtocol {

    // MARK: Stored Attributes

    @Persisted var activityId: String!
    @Persisted var title: String!
    @Persisted var notes: String = ""
    @Persisted var date: Date!
    @Persisted var place: String = ""
    @Persisted var timeSpent: Float = 0

    var fitnessType: FitnessType = .running

    // MARK: Relationship

    let user = LinkingObjects(fromType: User.self, property: "fitness")


    // MARK: Init

    // MARK: Class Methods
}

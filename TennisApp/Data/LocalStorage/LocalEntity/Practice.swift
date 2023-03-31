//
//  Practice.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class Practice: Object, PracticeProtocol {

    // MARK: Stored Attributes

    @Persisted var activityId: String!
    @Persisted var title: String!
    @Persisted var notes: String = ""
    @Persisted var date: Date!
    @Persisted var place: String = ""
    @Persisted var timeSpent: Float = 0

    var practiceType: PracticeType = .forehand

    // MARK: Relationship

    let user = LinkingObjects(fromType: User.self, property: "practices")

    // MARK: Init

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }

    // MARK: Class Methods
}

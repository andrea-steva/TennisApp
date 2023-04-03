//
//  StringsEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

final class StringsEntity: Object {

    // MARK: Stored Attributes

    @Persisted var stringId: String!
    @Persisted var manufacter: String!
    @Persisted var model: String!
    @Persisted var price: String = ""
    @Persisted var gauge: String = ""
    @Persisted var duration: Float = 0
    @Persisted var tension: Float = 0

    // MARK: Relationship

    let racket = LinkingObjects(fromType: RacketEntity.self, property: "strings")

    // MARK: Init

    required init(_ dictionary: [String: Any?]) {
        super.init()
        self.stringId = UUID().uuidString
        self.mapping(dictionary)
    }

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }


    func updateFrom(dictionary: [String: Any?]) {
        self.mapping(dictionary)
    }
    
    private func mapping(_ dictionary: [String: Any?]) {
        self.manufacter = dictionary["manufacter"] as? String
        self.model = dictionary["model"] as? String
    }
}

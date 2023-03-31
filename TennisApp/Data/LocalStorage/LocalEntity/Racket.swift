//
//  Racket.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

final class Racket: Object {
    
    // MARK: Stored Attributes
    
    @Persisted var racketId: String!
    @Persisted var manufacter: String!
    @Persisted var model: String!
    @Persisted var weight: String!
    @Persisted var gripSize: String!  //from 0 to 4
    @Persisted var image: Data?
    @Persisted var purchaseDate: Date?
    
    // MARK: Relationship
    
    let user = LinkingObjects(fromType: User.self, property: "rackets")
    var strings = List<Strings>()

    // MARK: Init

    required init(_ dictionary: [String: Any?]) {
        super.init()
        self.racketId = UUID().uuidString
        self.mapping(dictionary)
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    // MARK: Class Methods
    
    func updateFrom(dictionary: [String: Any?]) {
        self.mapping(dictionary)
    }
    
    fileprivate func mapping(_ dictionary: [String: Any?]) {
        self.manufacter = dictionary["manufacter"] as! String?
        self.model = dictionary["model"] as! String?
        self.weight = dictionary["weight"] as! String?
        self.gripSize = dictionary["gripSize"] as! String?
        self.purchaseDate = dictionary["purchaseDate"] as! Date?
    }
}

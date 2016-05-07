//
//  TNMatchScore.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class TNMatchScore: Object {
    
    //MARK: Stored Attributes
    
    dynamic var gamePlayerA : Int = 0
    dynamic var gamePlayerB : Int = 0

    //MARK: Relationship
    
    let match = LinkingObjects(fromType: TNMatch.self, property: "scores")
    
    //MARK: Init
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
    }
    
    convenience init(gamePlayerA : Int, gamePlayerB : Int) {
        self.init()
        self.gamePlayerA = gamePlayerA;
        self.gamePlayerB = gamePlayerB;
        
    }
    
    //MARK: Class Methods
    
    func matchScoreToString() -> String {
        return "\(self.gamePlayerA)-\(self.gamePlayerB)";
    }

}

//
//  TNMatchScore.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import RealmSwift

class TNMatchScore: Object {
    
    //MARK: Stored Attributes
    
    dynamic var gamePlayerA : Int = 0
    dynamic var gamePlayerB : Int = 0

    //MARK: Relationship
    
        var match: [TNMatch] {
            // Realm doesn't persist this property because it only has a getter defined
            // Define "user" as the inverse relationship to TNUser.activities
            return linkingObjects(TNMatch.self, forProperty: "scores")
        }
    
    //MARK: Methods
    
    required init() {
        super.init()
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
    }
    
    convenience init(gamePlayerA : Int, gamePlayerB : Int) {
        self.init()
        self.gamePlayerA = gamePlayerA;
        self.gamePlayerB = gamePlayerB;
        
    }
    
    func matchScoreToString() -> String {
        return "\(self.gamePlayerA)-\(self.gamePlayerB)";
    }

}

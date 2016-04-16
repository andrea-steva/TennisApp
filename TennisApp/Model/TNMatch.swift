//
//  TNMatch.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

class TNMatch: TNActivity {
 
    //MARK: Stored Attributes
    
    dynamic var playerNameA : String!
    dynamic var playerNameAB : String!
    var matchType : MatchType = .kSingle

    //MARK: Relationship
    
    var scores = List<TNMatchScore>()
        
    //MARK: Class Methods
    
    func isMatchWon() -> Bool {
        
        var countGamePlayerA = 0;
        var countGamePlayerB = 0;
        for score in self.scores {
            countGamePlayerA += score.gamePlayerA;
            countGamePlayerB += score.gamePlayerB;
        }
        if(countGamePlayerA > countGamePlayerB) {
            return true;
        }
        return false;
    }
}

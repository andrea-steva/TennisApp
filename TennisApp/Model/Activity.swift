//
//  Activity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

protocol ActivityProtocol {
    var activityId : String! { get set }
    var title : String! { get set }
    var notes : String { get set }
    var date : Date! { get set }
    var place : String { get set }
    var timeSpent : Float { get set }
}

extension ActivityProtocol {

}

protocol MatchProtocol {
    var playerNameA: String! { get set }
    var playerNameAB: String! { get set }
    var matchType: MatchType { get set }
}

protocol FitnessProtocol {
    var fitnessType : FitnessType { get set }
}

protocol PracticeProtocol {
    var practiceType : PracticeType { get set }
}

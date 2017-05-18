//
//  RealmProxyTests.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 29/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import XCTest
@testable import RealmSwift
@testable import TennisApp

class RealmProxyTests: XCTestCase {
    
    let realmProxy = RealmProxy(injectedRealm: try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "test")))
    
    func test_0_populate() {
        
        var rackets: [Racket] = []
        
        for index in 0 ..< 10 {
            let racket = Racket()
            racket.racketId = "RKT_\(index)"
            racket.purchaseDate = Date().addDays(index)
            rackets.append(racket)
        }
        realmProxy.saveObjects(rackets) { (racket) in }
    }
    
    func test_getAllObjects() {

        let results = realmProxy.getAllObjects(sortedBy: "purchaseDate") as Results<Racket>
        XCTAssertTrue(results.count == 10, "Number of object should be: 10")
    }
}

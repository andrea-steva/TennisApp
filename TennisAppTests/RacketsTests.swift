//
//  RacketsTests.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import XCTest
@testable import RealmSwift
@testable import TennisApp

class FakeRacketsService: RacketsServiceProtocol {
    
    let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "test"))
    
    func fetchRackets() -> Results<Racket> {
        let realmProxy = RealmProxy(injectedRealm: realm)
        return realmProxy.getAllObjects()
    }
    
    func deleteRacket(racket: Racket) {
        let realmProxy = RealmProxy(injectedRealm: realm)
        realmProxy.deleteObject(racket) { (racket) in
        }
    }
    
    func saveRacket(racket: Racket, saveBlock: ((_ racket: Racket) -> Void)?) {
        let realmProxy = RealmProxy(injectedRealm: realm)
        realmProxy.saveObject(racket) { (racket) in
        }
    }
}

class RacketsTests: XCTestCase {
    
    let fakeRacketsService = FakeRacketsService()
    
    func test_1_fetchRackets() {
        let sut = RacketsRepo(racketsService: fakeRacketsService)
        XCTAssertTrue(sut.getRackets().count == 0, "Number of rackets should be: 0")
    }
    
    func test_2_saveRacket() {
        let sut = RacketsRepo(racketsService: fakeRacketsService)
        
        sut.saveRacket(racket: Racket())
        XCTAssertTrue(sut.getRackets().count == 1, "Number of rackets should be: 1")
    }
    
    func test_3_deleteRacket() {
        let sut = RacketsRepo(racketsService: fakeRacketsService)
        
        let rackets = sut.getRackets()
        sut.deleteRacket(racket: rackets.first!)
        XCTAssertTrue(sut.getRackets().count == 0, "Number of rackets should be: 0")
    }
}

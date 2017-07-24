//
//  RacketsTests.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import XCTest
@testable import TennisApp

class FakeRacketsService: RacketsServiceProtocol {
    
    let storage = try! RealmStorageContext(configuration: ConfigurationType.inMemory(identifier: "test"))
    
    func fetchRackets(block: @escaping ([Racket]) -> Void) {
        let sort = Sorted(key: "purchaseDate", ascending: false)
        storage.fetch(Racket.self, predicate: nil, sorted: sort, completion: { (rackets) in
            block(rackets)
        })
    }
    
    func deleteRacket(racket: Racket) {
        do {
            try storage.delete(object: racket)
        } catch {
        }
    }
    
    func createRacket(racket: Racket) {
        do {
            try storage.create(object: racket, completion: { (racket) in
            })
        } catch {
        }
    }
    
    func updateRacket(block: @escaping () -> Void) {
        do {
            try storage.update(block: {
                block()
            })
        } catch _ as NSError {
        }
    }
}

class RacketsTests: XCTestCase {
    
    let fakeRacketsService = FakeRacketsService()
    
    var racket: Racket!
    
    func test_1_fetchRackets() {
        let exp = self.expectation(description: "waiting for fetch object")
        
        let sut = fakeRacketsService
        sut.fetchRackets { (rackets) in
            XCTAssertTrue(rackets.count == 0, "Number of rackets should be: 0")
            
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 2)
    }
    
    func test_2_createRacket() {
        let exp = self.expectation(description: "waiting for fetch object")
        
        let sut = fakeRacketsService
        
        let racket = Racket()
        racket.racketId = UUID().uuidString
        racket.manufacter = "Wilson"
        racket.model = "Prostaff 97LS"
        
        sut.createRacket(racket: racket)
        sut.fetchRackets { (rackets) in
            self.racket = rackets.first!
            XCTAssertTrue(rackets.count == 1, "Number of rackets should be: 1")
            
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 2)
    }
    
    func test_3_deleteRacket() {
        let exp = self.expectation(description: "waiting for fetch object")
        
        let sut = fakeRacketsService
        
        sut.deleteRacket(racket: self.racket)
        sut.fetchRackets { (rackets) in
            XCTAssertTrue(rackets.count == 0, "Number of rackets should be: 0")
            
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 2)
    }
}

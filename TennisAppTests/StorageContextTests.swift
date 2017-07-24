//
//  StorageContextTests.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 22/07/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import XCTest
@testable import TennisApp

class StorageContextTests: XCTestCase {
    
    var storage: StorageContext?
    
    override func setUp() {
        super.setUp()
        
        do {
            try self.storage = RealmStorageContext(configuration: ConfigurationType.inMemory(identifier: self.name!))
        } catch {
            XCTFail()
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        do {
            try self.storage?.deleteAll(Racket.self)
        } catch {
            XCTFail()
        }
    }
    
    func testCreateEmptyRecord() {
        let exp = self.expectation(description: "waiting for object created")
        
        let racket = Racket()
        racket.racketId = UUID().uuidString
        racket.manufacter = "Wilson"
        racket.model = "Prostaff 97LS"
        
        
        try! self.storage?.create(object: racket, completion: { (storedObject) in
            print("😚🤠: \(storedObject)")
            
            exp.fulfill()
        })
        
        self.waitForExpectations(timeout: 2)
    }
    
    func testSaveRecord() {
        let racket = Racket()
        racket.manufacter = "Wilson"
        racket.model = "Prostaff 97LS"
        
        do {
            try self.storage?.save(object: racket)
        } catch _ as NSError {
            XCTFail("Impossible to save the current object")
        }
    }
    
    func testSaveAndFetch() {
        self.testSaveRecord()
        
        do {
            let exp = self.expectation(description: "wait for fetch")
            
            self.storage?.fetch(Racket.self, predicate: nil, sorted: nil, completion: { (records) in
                XCTAssertEqual(records.count, 1)
                exp.fulfill()
            })
            
            self.waitForExpectations(timeout: 2, handler: nil)
        }
    }
}

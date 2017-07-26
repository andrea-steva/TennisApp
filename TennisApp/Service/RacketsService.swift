//
//  RacketService.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketsServiceProtocol {
    func fetchRackets(block: @escaping (_ rackets: [Racket]) -> Void)
    func createRacket(racket: Racket)
    func updateRacket(block: @escaping () -> Void)
    func deleteRacket(racket: Racket)
}

final class RacketsService: RacketsServiceProtocol {
    
    fileprivate var storage: StorageContext?
    
    init() {
        self.storage = try! RealmStorageContext(configuration: ConfigurationType.basic(identifier: "tennis_db"))
    }
    
    func fetchRackets(block: @escaping (_ rackets: [Racket]) -> Void) {
        let sort = Sorted(key: "purchaseDate", ascending: false)
        self.storage?.fetch(Racket.self, predicate: nil, sorted: sort, completion: { (rackets) in
            block(rackets)
        })
    }
    
    func createRacket(racket: Racket) {
        do {
            try self.storage?.create(object: racket, completion: { (racket) in
            })
        } catch _ as NSError {
        }
    }
    
    func updateRacket(block: @escaping () -> Void) {
        do {
            try self.storage?.update(block: {
                block()
            })
        } catch _ as NSError {
        }
    }
    
    func deleteRacket(racket: Racket) {
        do {
            try self.storage?.delete(object: racket)
        } catch _ as NSError {
        }
    }
}

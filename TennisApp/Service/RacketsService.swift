//
//  RacketService.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import RealmSwift

protocol RacketsServiceProtocol {
    func fetchRackets() -> Results<Racket>
    func saveRacket(racket: Racket, saveBlock: ((_ racket: Racket) -> Void)?)
    func deleteRacket(racket: Racket)
}

final class RacketsService: RacketsServiceProtocol {
    
    func fetchRackets() -> Results<Racket> {
        let rackets = RealmProxy().getAllObjects(sortedBy: "purchaseDate") as Results<Racket>
        return rackets
    }
    
    func deleteRacket(racket: Racket) {
        RealmProxy().deleteObject(racket) { (racket) in
        }
    }
    
    func saveRacket(racket: Racket, saveBlock: ((_ racket: Racket) -> Void)?) {
        RealmProxy().saveObject(racket) { (racket) in
            saveBlock?(racket)
        }
    }
}

final class RacketsRepo {
    
    private let rackets: Results<Racket>
    private let service: RacketsServiceProtocol
    
    init(racketsService: RacketsServiceProtocol) {
        self.service = racketsService
        self.rackets = racketsService.fetchRackets()
    }
    
    func getRackets() -> Results<Racket> {
        return rackets
    }
    
    func deleteRacket(racket: Racket) {
        self.service.deleteRacket(racket: racket)
    }
    
    func saveRacket(racket: Racket, saveBlock: ((_ racket: Racket) -> Void)? = nil) {
        self.service.saveRacket(racket: racket, saveBlock: saveBlock)
    }
}

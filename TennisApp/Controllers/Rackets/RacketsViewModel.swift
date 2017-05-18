//
//  RacketsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import RealmSwift

final class RacketsViewModel: BaseViewModel {

    // MARK: Properties

    fileprivate let racketsRepo = RacketsRepo(racketsService: RacketsService())

    var rackets: Results<Racket>?

    // MARK: Methods

    override init() {
        rackets = racketsRepo.getRackets()
    }

    func numberOfRackets() -> Int {
        guard let racketsCount = rackets?.count else {
            return 0
        }
        return racketsCount
    }

    func racket(forIndex index: Int) -> Racket {
        guard let racket = rackets?[index] else {
            return Racket()
        }
        return racket
    }

    func deleteRacket(forIndex index: Int) {
        guard let racket = rackets?[index] else {
            return
        }
        racketsRepo.deleteRacket(racket: racket)
    }

    func addTestRacket() {
        let racket = Racket()
        racket.racketId = UUID().uuidString
        racket.manufacter = "Wilson"
        racket.model = "Blade"
        racket.gripSize = "2"
        racket.weight = "300"
        racket.purchaseDate = Date()
        racketsRepo.saveRacket(racket: racket)
    }
}

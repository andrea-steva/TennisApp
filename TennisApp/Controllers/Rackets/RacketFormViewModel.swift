//
//  RacketFormViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RealmSwift

final class RacketFormViewModel: BaseViewModel {

    // MARK: Properties

    fileprivate let racketsRepo = RacketsRepo(racketsService: RacketsService())

    var newRacket: Bool = true
    var racket: Racket?

    // MARK: Methods

    override init() {

    }

    func creareOrUpdateRacket(formValues: [String: Any?]) {
        //Create the new racket if necessary
        if newRacket {
            racket = Racket()
            racket!.racketId = UUID().uuidString
        }

        //Update racket
        if let racket = self.racket {
            self.racketsRepo.saveRacket(racket: racket, saveBlock: { (racket) in
                racket.updateFrom(dict: formValues)
            })
        }
    }
}

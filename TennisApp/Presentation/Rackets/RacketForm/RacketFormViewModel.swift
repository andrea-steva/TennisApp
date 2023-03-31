//
//  RacketFormViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol RacketFormViewModelCoordinatorDelegate: class {
    func racketFormViewModelSaveRacket()
}

final class RacketFormViewModel: BaseViewModel {
    
    // MARK: Coordinator
    
    weak var coordinatorDelegate: RacketFormViewModelCoordinatorDelegate?
    
    // MARK: Properties
    
    fileprivate let racketsService = RacketsService()
    private var racket: Racket?
    
    // MARK: Methods
    
    init(racket: Racket?) {
        super.init()
        self.racket = racket
    }
    
    func getRacket() -> Racket? {
        return racket
    }
    
    func creareOrUpdateRacket(formValues: [String: Any?]) {
        if let racket = self.racket {
            self.racketsService.updateRacket(block: {
                racket.updateFrom(dictionary: formValues)
            })
        } else {
            racket = Racket(formValues)
            self.racketsService.createRacket(racket: racket!)
        }
    }
    
    func toRackets() {
        self.coordinatorDelegate?.racketFormViewModelSaveRacket()
    }
}

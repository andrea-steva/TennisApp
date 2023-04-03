//
//  RacketFormViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol RacketFormViewModelCoordinatorDelegate: AnyObject {
    func racketFormViewModelSaveRacket()
}

final class RacketFormViewModel: BaseViewModel {
    
    // MARK: Coordinator
    
    weak var coordinatorDelegate: RacketFormViewModelCoordinatorDelegate?
    
    // MARK: Properties
    
    fileprivate let racketsService = RacketRealmStorage()
    private var racket: RacketEntity?
    
    // MARK: Methods
    
    init(racket: RacketEntity?) {
        super.init()
        self.racket = racket
    }
    
    func getRacket() -> RacketEntity? {
        return racket
    }
    
    func creareOrUpdateRacket(formValues: [String: Any?]) {
        if let racket = self.racket {
            self.racketsService.updateRacket(block: {
                racket.updateFrom(dictionary: formValues)
            })
        } else {
            racket = RacketEntity(formValues)
            self.racketsService.createRacket(racket: racket!)
        }
    }
    
    func toRackets() {
        self.coordinatorDelegate?.racketFormViewModelSaveRacket()
    }
}

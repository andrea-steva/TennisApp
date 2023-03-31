//
//  RacketsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Bond

protocol RacketsViewModelCoordinatorDelegate: AnyObject {
    func racketsViewModelToStrings(viewModel: RacketsViewModel)
    func racketsViewModelToRacketForm(racket: Racket?)
}

final class RacketsViewModel: BaseViewModel {

    // MARK: Coordinator
    
    weak var coordinatorDelegate: RacketsViewModelCoordinatorDelegate?
    
    // MARK: Properties
    
    let reloadView = Observable(false)

    fileprivate let racketsService = RacketsService()

    var rackets: [Racket]?

    // MARK: Methods

    func fetchRackets() {
        racketsService.fetchRackets { (rackets) in
            self.rackets = rackets
            self.reloadView.value = true
        }
    }

    func numberOfRackets() -> Int {
        guard let count = rackets?.count else {
            return 0
        }
        return count
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
        racketsService.deleteRacket(racket: racket)
        self.fetchRackets()
    }
    
    // MARK: Coordinator Flow
    
    func toStrings() {
        self.coordinatorDelegate?.racketsViewModelToStrings(viewModel: self)
    }
    
    func toRacketForm(index: Int) {
        self.coordinatorDelegate?.racketsViewModelToRacketForm(racket: rackets![index])
    }
    
    func toEmptyRacketForm() {
        self.coordinatorDelegate?.racketsViewModelToRacketForm(racket: nil)
    }
}

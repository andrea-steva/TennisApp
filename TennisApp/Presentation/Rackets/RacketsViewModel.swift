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

    private let racketsFetchUseCase: RacketsFetchUseCase
    private let racketDeleteUseCase: RacketDeleteUseCase

    var rackets: [Racket] = []

    // MARK: Methods

    init(racketsFetchUseCase: RacketsFetchUseCase,
         racketDeleteUseCase: RacketDeleteUseCase) {
        self.racketsFetchUseCase = racketsFetchUseCase
        self.racketDeleteUseCase = racketDeleteUseCase
    }

    func fetchRackets() {
        racketsFetchUseCase.execute(page: 0, pageSize: 0) { result in
            switch result {
            case .success(let rackets):
                self.rackets = rackets
                self.reloadView.value = true
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }

    func numberOfRackets() -> Int {
        rackets.count
    }

    func racket(forIndex index: Int) -> Racket {
        rackets[index]
    }

    func deleteRacket(forIndex index: Int) {
        racketDeleteUseCase.execute(racket: rackets[index]) { result in
            switch result {
            case .success:
                self.rackets.remove(at: index)
                self.reloadView.value = true
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
        // TODO Implement delete use case
        // let racketToDelete = rackets[index]
        // Add delete racket use case and reload
    }
    
    // MARK: Coordinator Flow
    
    func toStrings() {
        self.coordinatorDelegate?.racketsViewModelToStrings(viewModel: self)
    }
    
    func toRacketForm(index: Int) {
        self.coordinatorDelegate?.racketsViewModelToRacketForm(racket: rackets[index])
    }
    
    func toEmptyRacketForm() {
        self.coordinatorDelegate?.racketsViewModelToRacketForm(racket: nil)
    }
}

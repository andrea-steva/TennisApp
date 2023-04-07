//
//  RacketsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine

protocol RacketsViewModelCoordinatorDelegate: AnyObject {
    func racketsViewModelToStrings(viewModel: RacketsViewModel)
    func racketsViewModelToRacketForm(racket: Racket?)
}

final class RacketsViewModel: BaseViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: RacketsViewModelCoordinatorDelegate?

    // MARK: Use Cases

    private let racketsFetchUseCase: RacketsFetchUseCase
    private let racketDeleteUseCase: RacketDeleteUseCase

    // MARK: Data Source

    private var rackets: [Racket] = []

    // MARK: Output

    var reloadViewData: AnyPublisher<Result<Void, Error>, Never> {
        reloadRacketsSubject.eraseToAnyPublisher()
    }

    private let reloadRacketsSubject = PassthroughSubject<Result<Void, Error>, Never>()

    // MARK: Methods

    init(racketsFetchUseCase: RacketsFetchUseCase,
         racketDeleteUseCase: RacketDeleteUseCase) {
        self.racketsFetchUseCase = racketsFetchUseCase
        self.racketDeleteUseCase = racketDeleteUseCase
    }

    func fetchRackets() {
        racketsFetchUseCase.execute(page: 0, pageSize: 0) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let rackets):
                self.rackets = rackets
                self.reloadRacketsSubject.send(.success(()))
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }

    func numberOfRackets() -> Int {
        rackets.count
    }

    func getRacket(forIndex index: Int) -> RacketCellViewModelType {
        RacketCellViewModel(racket: rackets[index])
    }

    func deleteRacket(forIndex index: Int) {
        racketDeleteUseCase.execute(racket: rackets[index]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                self.rackets.remove(at: index)
                self.reloadRacketsSubject.send(.success(()))
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
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

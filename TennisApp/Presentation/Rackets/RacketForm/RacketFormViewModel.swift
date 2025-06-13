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

final class RacketFormViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: RacketFormViewModelCoordinatorDelegate?

    // MARK: Properties

    private let racketSaveUseCase: RacketSaveUseCase
    private let racket: Racket?

    var isUpdate: Bool {
        racket != nil
    }

    // MARK: Methods

    init(racketSaveUseCase: RacketSaveUseCase,
         racket: Racket?) {
        self.racketSaveUseCase = racketSaveUseCase
        self.racket = racket
    }

    func getRacket() -> Racket? {
        racket
    }

    func createRacket(formValues: [String: Any?]) {
        racketSaveUseCase.execute(racket: Racket(racket: nil, formData: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Create racket \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }

    func updateRacket(racket: Racket, formValues: [String: Any?]) {
        racketSaveUseCase.execute(racket: Racket(racket: racket, formData: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Update racket \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }

    // MARK: Coordinator

    func toRackets() {
        self.coordinatorDelegate?.racketFormViewModelSaveRacket()
    }
}

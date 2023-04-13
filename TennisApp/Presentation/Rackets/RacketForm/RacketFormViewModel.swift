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

    private let racketCreateUseCase: RacketCreateUseCase
    private let racketUpdateUseCase: RacketUpdateUseCase
    private let racket: Racket?

    var isUpdate: Bool {
        racket != nil
    }

    // MARK: Methods

    init(racketCreateUseCase: RacketCreateUseCase,
         racketUpdateUseCase: RacketUpdateUseCase,
         racket: Racket?) {
        self.racketCreateUseCase = racketCreateUseCase
        self.racketUpdateUseCase = racketUpdateUseCase
        self.racket = racket
    }

    func getRacket() -> Racket? {
        racket
    }

    func createRacket(formValues: [String: Any?]) {
        racketCreateUseCase.execute(racket: Racket(form: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Create racket \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }

    func updateRacket(racket: Racket, formValues: [String: Any?]) {
        racketUpdateUseCase.execute(racket: Racket(racket: racket, form: formValues)) { result in
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

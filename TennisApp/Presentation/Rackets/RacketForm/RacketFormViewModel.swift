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
    
    private let racketCreateUseCase: RacketCreateUseCase
    private let racketUpdateUseCase: RacketUpdateUseCase
    private let racket: Racket?

    var isUpdate: Bool {
        racket != nil
    }
    
    // MARK: Methods

    init(racket: Racket?) {
        self.racket = racket
        let repository = DefaultRacketsRepository()
        racketCreateUseCase = DefaultRacketCreateUseCase(racketsRepository: repository)
        racketUpdateUseCase = DefaultRacketUpdateUseCase(racketsRepository: repository)
    }

    func getRacket() -> Racket? {
        racket
    }

    func createRacket(formValues: [String: Any?]) {
        // TODO Create racket from formValues (add helper on ´Rackets´)
        racketCreateUseCase.execute(racket: Racket(form: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Create racket \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }

    func updateRacket(formValues: [String: Any?]) {
        // TODO update racket properties from formValues (add helper on ´Rackets´)
        racketUpdateUseCase.execute(racket: Racket(form: formValues)) { result in
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

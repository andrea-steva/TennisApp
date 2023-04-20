//
//  StringFormCreateViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol StringFormViewModelCoordinatorDelegate: AnyObject {
    func stringFormViewModelSaveString()
}

final class StringFormCreateViewModel: StringFormViewModelType {

    // MARK: Coordinator

    weak var coordinatorDelegate: StringFormViewModelCoordinatorDelegate?

    // MARK: Properties

    private let stringsSaveUseCase: StringsSaveUseCase
    private let racket: Racket

    // MARK: Methods

    init(stringsSaveUseCase: StringsSaveUseCase,
         racket: Racket) {
        self.stringsSaveUseCase = stringsSaveUseCase
        self.racket = racket
    }

    func getString() -> Strings? { nil }

    func send(formValues: [String: Any?]) {
        stringsSaveUseCase.execute(string: Strings(string: nil, form: formValues), racket: self.racket) { result in
            switch result {
            case .success(let success):
                Log.debug("Create strings \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }
}

//
//  StringFormUpdateViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 19/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

final class StringFormUpdateViewModel: StringFormViewModelType {

    // MARK: Coordinator

    weak var coordinatorDelegate: StringFormViewModelCoordinatorDelegate?

    // MARK: Properties

    private let stringsSaveUseCase: StringsSaveUseCase
    private let racket: Racket
    private let string: Strings

    // MARK: Methods

    init(stringsSaveUseCase: StringsSaveUseCase,
         racket: Racket,
         string: Strings) {
        self.stringsSaveUseCase = stringsSaveUseCase
        self.racket = racket
        self.string = string
    }

    func getString() -> Strings? { string }

    func send(formValues: [String: Any?]) {
        stringsSaveUseCase.execute(string: Strings(string: string, form: formValues),
                                   racket: racket) { result in
            switch result {
            case .success(let success):
                Log.debug("Update strings \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }
}

//
//  StringFormViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol StringFormViewModelCoordinatorDelegate: AnyObject {
    func stringFormViewModelSaveString()
}

final class StringFormViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: StringFormViewModelCoordinatorDelegate?

    // MARK: Properties

    private let stringsCreateUseCase: StringsCreateUseCase
    private let stringsUpdateUseCase: StringsUpdateUseCase
    private let string: Strings?

    var isUpdate: Bool {
        string != nil
    }

    // MARK: Methods

    init(stringsCreateUseCase: StringsCreateUseCase,
         stringsUpdateUseCase: StringsUpdateUseCase,
         string: Strings?) {
        self.stringsCreateUseCase = stringsCreateUseCase
        self.stringsUpdateUseCase = stringsUpdateUseCase
        self.string = string
    }

    func getString() -> Strings? {
        string
    }

    func createStrings(formValues: [String: Any?]) {
        stringsCreateUseCase.execute(string: Strings(form: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Create strings \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }

    func updateStrings(string: Strings, formValues: [String: Any?]) {
        stringsUpdateUseCase.execute(string: Strings(string: string, form: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Update strings \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }
}

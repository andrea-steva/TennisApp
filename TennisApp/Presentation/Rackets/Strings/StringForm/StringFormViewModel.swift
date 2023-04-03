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

final class StringFormViewModel: BaseViewModel {
    
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


    init(string: Strings?) {
        self.string = string
        let repository = DefaultStringsRepository()
        stringsCreateUseCase = DefaultStringsCreateUseCase(stringsRepository: repository)
        stringsUpdateUseCase = DefaultStringsUpdateUseCase(stringsRepository: repository)
    }
    
    func getString() -> Strings? {
        return string
    }

    func createStrings(formValues: [String: Any?]) {
        // TODO Create strings from formValues (add helper on ´Strings´)
        stringsCreateUseCase.execute(strings: Strings(form: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Create strings \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }

    func updateStrings(formValues: [String: Any?]) {
        // TODO update strings properties from formValues (add helper on ´Strings´)
        stringsUpdateUseCase.execute(strings: Strings(form: formValues)) { result in
            switch result {
            case .success(let success):
                Log.debug("Update strings \(success)")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
        }
    }
}

//
//  StringFormViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

protocol StringFormViewModelCoordinatorDelegate: class {
    func stringFormViewModelSaveString()
}

final class StringFormViewModel: BaseViewModel {
    
    // MARK: Coordinator
    
    weak var coordinatorDelegate: StringFormViewModelCoordinatorDelegate?
    
    // MARK: Properties
    
    fileprivate let stringsService = StringsService()
    fileprivate var string: Strings?
    
    // MARK: Methods
    
    init(string: Strings?) {
        super.init()
        self.string = string
    }
    
    func getString() -> Strings? {
        return string
    }
    
    func creareOrUpdateString(formValues: [String: Any?]) {
        if let string = self.string {
            self.stringsService.updateString(block: { 
                string.updateFrom(dictionary: formValues)
            })
        } else {
            string = Strings(formValues)
            self.stringsService.createString(string: string!)
        }
    }
}

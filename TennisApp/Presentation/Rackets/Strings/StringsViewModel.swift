//
//  StringsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Bond

protocol StringsViewModelCoordinatorDelegate: AnyObject {
    func stringViewModelDidEnd(_ viewModel: StringsViewModel)
    func stringViewModelToStringForm(string: StringsEntity?)
}

final class StringsViewModel: BaseViewModel {

    // MARK: Coordinator
    
    weak var coordinatorDelegate: StringsViewModelCoordinatorDelegate?
    
    // MARK: Properties
    
    let reloadView = Observable(false)

    fileprivate let stringsService = StringsRealmStorage()

    var strings: [StringsEntity]?

    // MARK: Methods
    
    func fetchStrings() {
        stringsService.fetchStrings { (strings) in
            self.strings = strings
            self.reloadView.value = true
        }
    }

    func numberOfStrings() -> Int {
        guard let count = strings?.count else {
            return 0
        }
        return count
    }

    func string(forIndex index: Int) -> StringsEntity {
        guard let string = strings?[index] else {
            return StringsEntity()
        }
        return string
    }

    func deleteString(forIndex index: Int) {
        guard let string = strings?[index] else {
            return
        }
        stringsService.deleteString(string: string)
        self.fetchStrings()
    }
    
    // MARK: Coordinator Flow
    
    func backToRackets() {
        self.coordinatorDelegate?.stringViewModelDidEnd(self)
    }

    func toStringForm(index: Int) {
        self.coordinatorDelegate?.stringViewModelToStringForm(string: strings![index])
    }

    func toEmptyStringForm() {
        self.coordinatorDelegate?.stringViewModelToStringForm(string: nil)
    }
}

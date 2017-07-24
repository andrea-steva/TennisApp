//
//  StringsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RealmSwift

protocol StringsViewModelCoordinatorDelegate: class {
    func stringViewModelDidEnd(_ viewModel: StringsViewModel)
    func stringViewModelToStringForm(string: Strings?)
}

final class StringsViewModel: BaseViewModel {

    // MARK: Coordinator
    
    weak var coordinatorDelegate: StringsViewModelCoordinatorDelegate?
    
    // MARK: Properties

    fileprivate let stringsRepo = StringsRepo(stringsService: StringsService())

    var strings: Results<Strings>?

    // MARK: Methods

    override init() {
        strings = stringsRepo.getStrings()
    }

    func numberOfStrings() -> Int {
        guard let count = strings?.count else {
            return 0
        }
        return count
    }

    func string(forIndex index: Int) -> Strings {
        guard let string = strings?[index] else {
            return Strings()
        }
        return string
    }

    func deleteString(forIndex index: Int) {
        guard let string = strings?[index] else {
            return
        }
        stringsRepo.deleteString(string: string)
    }
    
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

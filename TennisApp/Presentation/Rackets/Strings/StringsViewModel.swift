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
    func stringViewModelToStringForm(string: Strings?)
}

final class StringsViewModel: BaseViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: StringsViewModelCoordinatorDelegate?

    // MARK: Properties

    let reloadView = Observable(false)

    private let stringsFetchUseCase: StringsFetchUseCase
    private let stringDeleteUseCase: StringsDeleteUseCase

    var strings: [Strings] = []

    // MARK: Methods

    init(stringsFetchUseCase: StringsFetchUseCase, stringDeleteUseCase: StringsDeleteUseCase) {
        self.stringsFetchUseCase = stringsFetchUseCase
        self.stringDeleteUseCase = stringDeleteUseCase
    }

    func fetchStrings() {
        stringsFetchUseCase.execute(page: 0, pageSize: 0) { result in
            switch result {
            case .success(let strings):
                self.strings = strings
                self.reloadView.value = true
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }

    func numberOfStrings() -> Int {
        strings.count
    }

    func string(forIndex index: Int) -> Strings {
        strings[index]
    }

    func deleteString(forIndex index: Int) {
        stringDeleteUseCase.execute(string: strings[index], completion: { result in
            switch result {
            case .success:
                self.strings.remove(at: index)
                self.reloadView.value = true
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        })
    }

    // MARK: Coordinator Flow

    func backToRackets() {
        self.coordinatorDelegate?.stringViewModelDidEnd(self)
    }

    func toStringForm(index: Int) {
        self.coordinatorDelegate?.stringViewModelToStringForm(string: strings[index])
    }

    func toEmptyStringForm() {
        self.coordinatorDelegate?.stringViewModelToStringForm(string: nil)
    }
}

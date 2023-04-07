//
//  StringsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine

protocol StringsViewModelCoordinatorDelegate: AnyObject {
    func stringViewModelDidEnd(_ viewModel: StringsViewModel)
    func stringViewModelToStringForm(string: Strings?)
}

final class StringsViewModel: BaseViewModel {

    // MARK: Coordinator

    weak var coordinatorDelegate: StringsViewModelCoordinatorDelegate?

    // MARK: Use Cases

    private let stringsFetchUseCase: StringsFetchUseCase
    private let stringDeleteUseCase: StringsDeleteUseCase

    // MARK: Data source

    var strings: [Strings] = []

    // MARK: Output

    var reloadViewData: AnyPublisher<Result<Void, Error>, Never> {
        reloadStringsSubject.eraseToAnyPublisher()
    }

    private let reloadStringsSubject = PassthroughSubject<Result<Void, Error>, Never>()

    // MARK: Methods

    init(stringsFetchUseCase: StringsFetchUseCase, stringDeleteUseCase: StringsDeleteUseCase) {
        self.stringsFetchUseCase = stringsFetchUseCase
        self.stringDeleteUseCase = stringDeleteUseCase
    }

    func fetchStrings() {
        stringsFetchUseCase.execute(page: 0, pageSize: 0) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let strings):
                self.strings = strings
                self.reloadStringsSubject.send(.success(()))
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }

    func numberOfStrings() -> Int {
        strings.count
    }

    func getString(forIndex index: Int) -> StringCellViewModel {
        StringCellViewModel(string: strings[index])
    }

    func deleteString(forIndex index: Int) {
        stringDeleteUseCase.execute(string: strings[index], completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                self.strings.remove(at: index)
                self.reloadStringsSubject.send(.success(()))
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

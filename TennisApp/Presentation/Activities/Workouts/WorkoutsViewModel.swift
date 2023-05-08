//
//  WorkoutsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine

final class WorkoutsViewModel {

    // MARK: Use Cases

    // MARK: Data Source

    private var workouts: [Workout] = []

    // MARK: Output

    var reloadViewData: AnyPublisher<Result<Void, Error>, Never> {
        reloadViewDataSubject.eraseToAnyPublisher()
    }

    private let reloadViewDataSubject = PassthroughSubject<Result<Void, Error>, Never>()

    // MARK: Methods

    init() {
    }

    func fetchWorkouts() {
        self.reloadViewDataSubject.send(.success(()))
    }

    func getViewModels() -> [WorkoutViewModel] {
        workouts.map { WorkoutViewModel(workout: $0) }
    }

    func deleteWorkout(forIndex index: Int) {
    }
}

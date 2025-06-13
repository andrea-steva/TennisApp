//
//  BaseViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Combine

protocol BindableViewModelType {
    var errorMessage: AnyPublisher<String, Never> { get }
    var errorMessageSubject: PassthroughSubject<String, Never> { get }

    var isLoading: AnyPublisher<Bool, Never> { get }
    var isLoadingSubject: PassthroughSubject<Bool, Never> { get }
}

extension BindableViewModelType {
    var isLoading: AnyPublisher<Bool, Never> { isLoadingSubject.eraseToAnyPublisher() }
    var errorMessage: AnyPublisher<String, Never> { errorMessageSubject.eraseToAnyPublisher() }
}

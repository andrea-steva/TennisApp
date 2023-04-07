//
//  BaseViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine

protocol BaseViewModelType {
    var errorMessage: AnyPublisher<String, Never> { get }
    var errorMessageSubject: PassthroughSubject<String, Never> { get }

    var isLoading: AnyPublisher<Bool, Never> { get }
    var isLoadingSubject: PassthroughSubject<Bool, Never> { get }
}

class BaseViewModel: BaseViewModelType {

    var errorMessage: AnyPublisher<String, Never> { errorMessageSubject.eraseToAnyPublisher() }
    let errorMessageSubject = PassthroughSubject<String, Never>()

    var isLoading: AnyPublisher<Bool, Never> { isLoadingSubject.eraseToAnyPublisher() }
    let isLoadingSubject = PassthroughSubject<Bool, Never>()
}

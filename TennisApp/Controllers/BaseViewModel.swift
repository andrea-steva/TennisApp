//
//  BaseViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Bond

class BaseViewModel {
    
    let isLoading = Observable<Bool>(false)
    let errorMessage = Observable<String?>(nil)
}

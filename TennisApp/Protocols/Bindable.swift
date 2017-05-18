//
//  Bindable.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol Bindable {
    func getViewModel() -> BaseViewModel?
    func bindViewModel()
    func bindLoader()
    func bindAlertError()
}

extension Bindable where Self: UIViewController {
    
    func getViewModel() -> BaseViewModel? {
        return nil
    }
    
    func bindViewModel() {
        
    }
    
    func bindLoader() {
        guard let viewModel = self.getViewModel() else {
            return
        }
        let _ = viewModel.isLoading.observeNext(with: { value in
            if value {
                Utils.showHUD(view: self.view)
            } else {
                Utils.hideHUD(view: self.view)
            }
        })
        
        let _ = viewModel.errorMessage.observeNext { (message) in
            if let message = message {
                AlertView.showWarning(localizer.get(LocalizedString.generic_alertTitle),
                                      message: message,
                                      controller: self)
            }
        }
    }
    
    func bindAlertError() {
        guard let viewModel = self.getViewModel() else {
            return
        }
        let _ = viewModel.errorMessage.observeNext { (message) in
            if let message = message {
                AlertView.showWarning(localizer.get(LocalizedString.generic_alertTitle),
                                      message: message,
                                      controller: self)
            }
        }
    }
}

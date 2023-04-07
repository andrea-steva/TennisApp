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

extension Bindable where Self: BaseViewController {

    func getViewModel() -> BaseViewModel? {
        nil
    }

    func bindViewModel() {
    }

    func bindLoader() {
        guard let viewModel = self.getViewModel() else {
            return
        }
        _ = viewModel.isLoading.observeNext(with: { value in
            if value {
                self.showHUD()
            } else {
                self.hideHUD()
            }
        })

        _ = viewModel.errorMessage.observeNext { (message) in
            if let message {
                AlertView.showWarning(self.localizer.get(LocalizationKeys.genericAlertTitle),
                                      message: message,
                                      controller: self)
            }
        }
    }

    func bindAlertError() {
        guard let viewModel = self.getViewModel() else {
            return
        }
        _ = viewModel.errorMessage.observeNext { (message) in
            if let message {
                AlertView.showWarning(self.localizer.get(LocalizationKeys.genericAlertTitle),
                                      message: message,
                                      controller: self)
            }
        }
    }
}

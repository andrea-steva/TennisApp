//
//  Bindable.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

protocol Bindable {
    func getViewModel() -> BaseViewModel
    func bindLoader()
    func bindAlertMessage()
}

extension Bindable where Self: BaseViewController {

    func bindLoader() {
        let viewModel = self.getViewModel()

        viewModel.isLoading.sink { [weak self] value in
            guard let self else { return }
            if value {
                self.showHUD()
            } else {
                self.hideHUD()
            }
        }
        .store(in: &subscriptions)
    }

    func bindAlertMessage() {
        let viewModel = self.getViewModel()

        viewModel.errorMessage.sink { [weak self] message in
            guard let self else { return }
            AlertView.showWarning(self.localizer.get(LocalizationKeys.genericAlertTitle),
                                  message: message,
                                  controller: self)
        }
        .store(in: &subscriptions)
    }
}

//
//  Bindable.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

protocol Bindable: AnyObject {
    var subscriptions: Set<AnyCancellable> { get set }

    func getViewModel() -> BindableViewModelType
    func bindLoader()
    func bindAlertMessage()
}

extension Bindable where Self: UIViewController, Self: LoadingIndicator, Self: Alertable {

    func bindLoader() {
        self.getViewModel().isLoading
            .sink { [weak self] value in
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
        self.getViewModel().errorMessage
            .sink { [weak self] message in
                guard let self else { return }
                self.showAlert(title: "Alert",
                               message: message)
            }
            .store(in: &subscriptions)
    }
}

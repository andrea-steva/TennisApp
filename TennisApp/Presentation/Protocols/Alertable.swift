//
//  Alertable.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {

    func showAlert(title: String, message: String,
                   preferredStyle: UIAlertController.Style = .alert,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: completion)
    }

    func showAlert(title: String, message: String,
                   preferredStyle: UIAlertController.Style = .alert,
                   confirmAction: ((UIAlertAction) -> Void)? = nil,
                   cancelAction: ((UIAlertAction) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: confirmAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: cancelAction))

        self.present(alert, animated: true, completion: nil)
    }
}

//
//  UITextField+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }
}

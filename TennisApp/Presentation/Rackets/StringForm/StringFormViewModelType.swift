//
//  StringFormViewModelType.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 19/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringFormViewModelType {
    var coordinatorDelegate: StringFormViewModelCoordinatorDelegate? { get set }

    func getString() -> Strings?
    func send(formValues: [String: Any?])
}

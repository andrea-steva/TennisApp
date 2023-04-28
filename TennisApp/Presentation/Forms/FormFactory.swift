//
//  FormBuilder.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 19/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Eureka

struct FormFactory {

    enum FormType {
        case racket(racket: Racket?)
        case string(string: Strings?)
    }

    func create(_ type: FormType) -> Form {
        switch type {
        case .racket(let racket):
            return RacketForm().create(prefillWith: racket)
        case .string(let string):
            return StringForm().create(prefillWith: string)
        }
    }
}

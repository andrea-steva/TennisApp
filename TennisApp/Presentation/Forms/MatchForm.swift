//
//  MatchForm.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Eureka
import ImageRow
import UIKit

struct MatchForm {

    struct Keys {
        static let scores = "scores"
    }

    func create() -> Form {

        let form = Form()
        let setArray = [0, 1, 2, 3, 4, 5, 6, 7]

        form +++ Section("Match information")
        +++
        MultivaluedSection(multivaluedOptions: .Insert, header: "Scores") {
            $0.showInsertIconInAddButton = false
            $0.multivaluedRowToInsertAt = { index in
                DoublePickerInlineRow<Int, Int>("score_\(index + 1)") {
                    $0.title = "Set \(index + 1)"
                    $0.tag = "\(index + 1)"
                    $0.firstOptions = { setArray }
                    $0.secondOptions = { _ in setArray }
                    $0.displayValueFor = {
                        "\($0?.a ?? 0) - \($0?.b ?? 0)"
                    }
                }
            }
        }
        return form
    }
}

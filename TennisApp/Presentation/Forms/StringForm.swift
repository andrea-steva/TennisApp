//
//  StringForm.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 27/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Eureka
import ImageRow
import UIKit

struct StringForm {

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    struct Keys {
        static let manufacter = "manufacter"
        static let model = "model"
        static let gauge = "gauge"
        static let duration = "duration"
        static let tension = "tension"
        static let price = "price"
        static let inUse = "inUse"
    }

    func create(prefillWith string: Strings?) -> Form {

        ImageRow.defaultCellUpdate = { cell, _ in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }

        let labelFont = designLibrary.font.textNormalSize.regular

        let form = Form()

        form +++ Section("Your string information")
        <<< AlertRow<String>(Self.Keys.manufacter) {
            $0.selectorTitle = "Manufacter"
            $0.title = "Manufacter"
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = labelFont
            }
            $0.options = StringsBrand.allCases.map { $0.rawValue }
            $0.value = string?.manufacter ?? ""
        }
        <<< TextRow(Self.Keys.model) {
            $0.add(rule: RuleRequired())
            $0.title = "Model"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = labelFont
                cell.titleLabel?.font = labelFont
            }
            $0.placeholder = "Revolve"
            $0.value = string?.model ?? ""
        }
        <<< TextRow(Self.Keys.gauge) {
            $0.title = "Gauge"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = labelFont
                cell.titleLabel?.font = labelFont
            }
            $0.placeholder = "1.30 mm"
            $0.value = string?.gauge ?? ""
        }
        <<< DecimalRow(Self.Keys.duration) {
            $0.title = "Duration"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = labelFont
                cell.titleLabel?.font = labelFont
            }
            $0.value = Double(string?.duration ?? 0)
        }
        <<< DecimalRow(Self.Keys.tension) {
            $0.title = "Tension"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = labelFont
                cell.titleLabel?.font = labelFont
            }
            $0.value = Double(string?.tension ?? 0)
        }
        <<< DecimalRow(Self.Keys.price) {
            $0.title = "Price"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = labelFont
                cell.titleLabel?.font = labelFont
            }
            $0.value = Double(string?.price ?? 0)
        }
        <<< SwitchRow(Self.Keys.inUse) {
            $0.title = "In use"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = labelFont
            }
        }

        return form
    }
}

//
//  RacketForm.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 27/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Eureka
import ImageRow
import UIKit

struct RacketForm {

    struct Keys {
        static let sport = "sport"
        static let manufacter = "manufacter"
        static let model = "model"
        static let gripSize = "gripSize"
        static let weight = "weight"
        static let purchaseDate = "purchaseDate"
        static let image = "image"
        static let price = "price"
        static let inUse = "inUse"
    }

    func create(prefillWith racket: Racket?) -> Form {

        ImageRow.defaultCellUpdate = { cell, _ in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }

        let form = Form()

        form +++ Section("Your racket information")
        <<< AlertRow<String>(Self.Keys.sport) {
            $0.selectorTitle = "Type"
            $0.title = "Type"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = Sport.allCases.map { $0.rawValue.capitalizeFirstLetter }
            $0.value = racket?.sport.rawValue ?? ""
        }
        <<< AlertRow<String>(Self.Keys.manufacter) {
            $0.selectorTitle = "Manufacter"
            $0.title = "Manufacter"
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = RacketBrand.allCases.map { $0.rawValue }
            $0.value = racket?.manufacter ?? ""
        }
        <<< TextRow(Self.Keys.model) {
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.title = "Model"
            $0.placeholder = "ProStaff 97S"
            $0.value = racket?.model ?? ""
        }
        <<< AlertRow<String>(Self.Keys.gripSize) {
            $0.selectorTitle = "Grip Size"
            $0.title = "Grip Size"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = GripSize.allCases.map { $0.rawValue }
            $0.value = racket?.gripSize.rawValue ?? ""
        }
        <<< IntRow(Self.Keys.weight) {
            $0.title = "Weight"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.placeholder = "0"
            $0.value = Int(racket?.weight ?? 0)
        }
        <<< DateRow(Self.Keys.purchaseDate) {
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.title = "Purchase Date"
            $0.value = racket?.purchaseDate ?? Date()
        }
        <<< ImageRow(Self.Keys.image) {
            $0.title = "Image"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.value = racket?.image
        }
        <<< DecimalRow(Self.Keys.price) {
            $0.title = "Price"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.value = Double(racket?.price ?? 0)
        }
        <<< SwitchRow(Self.Keys.inUse) {
            $0.title = "In use"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
        }

        return form
    }
}

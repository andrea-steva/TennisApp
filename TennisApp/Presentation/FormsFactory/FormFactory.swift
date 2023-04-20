//
//  FormBuilder.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 19/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Eureka
import ImageRow
import UIKit

struct FormFactory {

    enum FormType {
        case racket(racket: Racket?)
        case string(string: Strings?)
    }

    func build(_ type: FormType) -> Form {
        switch type {
        case .racket(let racket):
            return createRacketForm(prefillWith: racket)
        case .string(let string):
            return createStringForm(prefillWith: string)
        }
    }

    private func createRacketForm(prefillWith racket: Racket?) -> Form {

        ImageRow.defaultCellUpdate = { cell, _ in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }

        let form = Form()

        form +++ Section("Your racket information")
        <<< AlertRow<String>("sport") {
            $0.selectorTitle = "Type"
            $0.title = "Type"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = Sport.allCases.map { $0.rawValue.capitalizeFirstLetter }
            $0.value = racket?.sport.rawValue ?? ""
        }
        <<< AlertRow<String>("manufacter") {
            $0.selectorTitle = "Manufacter"
            $0.title = "Manufacter"
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = RacketBrand.allCases.map { $0.rawValue }
            $0.value = racket?.manufacter ?? ""
        }
        <<< TextRow("model") {
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.title = "Model"
            $0.placeholder = "ProStaff 97S"
            $0.value = racket?.model ?? ""
        }
        <<< AlertRow<String>("gripSize") {
            $0.selectorTitle = "Grip Size"
            $0.title = "Grip Size"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = GripSize.allCases.map { $0.rawValue }
            $0.value = racket?.gripSize.rawValue ?? ""
        }
        <<< IntRow("weight") {
            $0.title = "Weight"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.placeholder = "0"
            $0.value = Int(racket?.weight ?? 0)
        }
        <<< DateRow("purchaseDate") {
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.title = "Purchase Date"
            $0.value = racket?.purchaseDate ?? Date()
        }
        <<< ImageRow("image") {
            $0.title = "Image"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.value = racket?.image != nil ? UIImage(data: racket!.image!) : nil
        }
        <<< DecimalRow("price") {
            $0.title = "Price"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.value = Double(racket?.price ?? 0)
        }

        return form
    }

    private func createStringForm(prefillWith string: Strings?) -> Form {

        ImageRow.defaultCellUpdate = { cell, _ in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }

        let form = Form()

        form +++ Section("Your string information")
        <<< AlertRow<String>("manufacter") {
            $0.selectorTitle = "Manufacter"
            $0.title = "Manufacter"
            $0.add(rule: RuleRequired())
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = StringsBrand.allCases.map { $0.rawValue }
            $0.value = string?.manufacter ?? ""
        }
        <<< TextRow("model") {
            $0.add(rule: RuleRequired())
            $0.title = "Model"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.placeholder = "Revolve"
            $0.value = string?.model ?? ""
        }
        <<< TextRow("gauge") {
            $0.title = "Gauge"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.placeholder = "1.30 mm"
            $0.value = string?.gauge ?? ""
        }
        <<< DecimalRow("price") {
            $0.title = "Price"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.value = Double(string?.price ?? 0)
        }

        return form
    }
}

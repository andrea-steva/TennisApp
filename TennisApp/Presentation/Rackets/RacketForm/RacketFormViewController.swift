//
//  RacketFormViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Eureka
import ImageRow
import UIKit

final class RacketFormViewController: FormViewController, StoryboardInstantiable {

    // MARK: Properties

    let localizer = Localizer()

    // MARK: ViewModel

    var viewModel: RacketFormViewModel!

    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.racketsAddRacket)

        createForm()
    }

    func createForm() {
        let racket = viewModel.getRacket()

        ImageRow.defaultCellUpdate = { cell, _ in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }

        form +++ Section("Your racket information")
            <<< AlertRow<String>("manufacter") {
                $0.add(rule: RuleRequired())
                $0.title = "Manufacter"
                $0.options = RacketBrand.allCases.map { $0.rawValue }
                $0.value = racket?.manufacter ?? ""
            }
            <<< TextRow("model") {
                $0.add(rule: RuleRequired())
                $0.title = "Model"
                $0.placeholder = "ProStaff 97S"
                $0.value = racket?.model ?? ""
            }
            <<< AlertRow<String>("gripSize") {
                $0.title = "Grip Size"
                $0.options = ["1", "2", "3", "4", "5"]
                $0.value = racket?.gripSize.rawValue ?? ""
            }
            <<< IntRow("weight") {
                $0.title = "Weight"
                $0.placeholder = "0"
                $0.value = Int(racket?.weight ?? 0)
            }
            <<< DateRow("purchaseDate") {
                $0.add(rule: RuleRequired())
                $0.title = "Purchase Date"
                $0.value = racket?.purchaseDate ?? Date()
            }
            <<< ImageRow("image") {
                $0.title = "Image"
        }
    }

    @IBAction private func didTapOnSaveButton(_ sender: AnyObject) {
        let formValues = form.values()
        if let racket = viewModel.getRacket(), viewModel.isUpdate {
            viewModel.updateRacket(racket: racket, formValues: formValues)
        } else {
            viewModel.createRacket(formValues: formValues)
        }
        self.viewModel.toRackets()
    }
}

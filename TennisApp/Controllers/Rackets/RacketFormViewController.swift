//
//  RacketFormViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Eureka

class RacketFormViewController: FormViewController {

    // MARK: ViewModel

    var viewModel = RacketFormViewModel()

    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizedString.rackets_addRacket)

        createForm(racket: viewModel.racket)
    }

    func createForm(racket: Racket?) {

        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }

        form +++ Section("Your racket information")
            <<< PickerInlineRow<String>("manufacter") {
                $0.add(rule: RuleRequired())
                $0.title = "Manufacter"
                $0.options = ["Wilson", "Babolat", "Yonex"]
                $0.value = racket != nil ? racket!.manufacter : "Wilson"
            }
            <<< TextRow("model") {
                $0.add(rule: RuleRequired())
                $0.title = "Model"
                $0.placeholder = "ProStaff 97S"
                $0.value = racket != nil ? racket!.model : ""
            }
            <<< PickerInlineRow<String>("gripSize") {
                $0.title = "Grip Size"
                $0.options = ["1", "2", "3", "4", "5"]
                $0.value = racket != nil ? racket!.gripSize : "1"
            }
            <<< TextRow("weight") {
                $0.title = "Weight"
                $0.placeholder = "300"
                $0.value = racket != nil ? racket!.weight : ""
            }
            <<< DateRow("purchaseDate") {
                $0.add(rule: RuleRequired())
                $0.title = "Purchase Date"
                $0.value = racket != nil ? racket!.purchaseDate : Date()
            }
            <<< ImageRow("image") {
                $0.title = "Image"
        }

    }

    @IBAction func didTapOnSaveButton(_ sender: AnyObject) {
        let formValues = form.values()
        Log.debug(formValues)

        AlertView.showConfirm(localizer.get(LocalizedString.generic_alertTitle), message: "Are you sure to complete the operation?") { [unowned self] (userCancelAction) in

            if !userCancelAction {
                self.viewModel.creareOrUpdateRacket(formValues: formValues)
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

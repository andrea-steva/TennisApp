//
//  StringFormViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Eureka
import ImageRow
import UIKit

final class StringFormViewController: FormViewController, StoryboardInstantiable {

    // MARK: Properties

    let localizer = Localizer()

    // MARK: ViewModel

    var viewModel: StringFormViewModel!

    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.stringsAddString)
        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        createForm()
    }

    func createForm() {
        let string = viewModel.getString()

        ImageRow.defaultCellUpdate = { cell, _ in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }

        form +++ Section("Your string information")
        <<< AlertRow<String>("manufacter") {
            $0.add(rule: RuleRequired())
            $0.title = "Manufacter"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.options = RacketBrand.allCases.map { $0.rawValue }
            $0.value = string?.manufacter ?? "Wilson"
        }
        <<< TextRow("model") {
            $0.add(rule: RuleRequired())
            $0.title = "Model"
            $0.cellSetup { cell, _ in
                cell.textLabel?.font = Fonts.get(.regular, size: .normal)
            }
            $0.placeholder = "ProStaff 97S"
            $0.value = string?.model ?? ""
        }
    }

    @IBAction private func didTapOnSaveButton(_ sender: AnyObject) {
        let formValues = form.values()
        Log.debug(formValues.description)

        if let string = viewModel.getString(), viewModel.isUpdate {
            viewModel.updateStrings(string: string, formValues: formValues)
        } else {
            viewModel.createStrings(formValues: formValues)
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
}

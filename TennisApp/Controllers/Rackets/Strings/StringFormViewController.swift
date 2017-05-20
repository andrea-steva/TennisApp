//
//  StringFormViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Eureka

class StringFormViewController: FormViewController {
    
    // MARK: ViewModel
    
    var viewModel = StringFormViewModel()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = localizer.get(LocalizedString.strings_addString)
        
        createForm(string: viewModel.string)
    }
    
    func createForm(string: Strings?) {
        
        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }
        
        form +++ Section("Your string information")
            <<< PickerInlineRow<String>("manufacter") {
                $0.add(rule: RuleRequired())
                $0.title = "Manufacter"
                $0.options = RacketBrand.allValues
                $0.value = string != nil ? string!.manufacter : "Wilson"
            }
            <<< TextRow("model") {
                $0.add(rule: RuleRequired())
                $0.title = "Model"
                $0.placeholder = "ProStaff 97S"
                $0.value = string != nil ? string!.model : ""
        }
        
    }
    
    @IBAction func didTapOnSaveButton(_ sender: AnyObject) {
        let formValues = form.values()
        Log.debug(formValues)
        
        AlertView.showConfirm(localizer.get(LocalizedString.generic_alertTitle), message: "Update string's information") { [unowned self] (userCancelAction) in
            
            if !userCancelAction {
                self.viewModel.creareOrUpdateString(formValues: formValues)
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

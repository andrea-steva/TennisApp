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

    var viewModel: StringFormViewModelType!

    // MARK: Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.stringsAddString)
        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        createForm()
    }

    func createForm() {
        self.form = FormFactory().build(.string(string: viewModel.getString()))
    }

    @IBAction private func didTapOnSaveButton(_ sender: AnyObject) {
        let formValues = form.values()
        Log.debug(formValues.description)
        viewModel.send(formValues: formValues)

        _ = self.navigationController?.popViewController(animated: true)
    }
}

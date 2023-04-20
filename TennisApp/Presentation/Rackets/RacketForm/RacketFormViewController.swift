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

        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        createForm()
    }

    func createForm() {
        self.form = FormFactory().build(.racket(racket: viewModel.getRacket()))
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

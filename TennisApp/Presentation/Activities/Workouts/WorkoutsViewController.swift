//
//  WorkoutsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class WorkoutsViewController: UIViewController, StoryboardInstantiable {

    // MARK: ViewModel

    var viewModel: WorkoutsViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.fetchWorkouts()
    }
}

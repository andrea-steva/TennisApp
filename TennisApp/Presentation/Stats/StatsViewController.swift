//
//  StatsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

class StatsViewController: BaseViewController, StoryboardInstantiable {

    // MARK: IBOutlets

    // MARK: ViewModel

    var viewModel: StatsViewModel!

    // MARK: View Management

    override func localizedTitleString() -> String {
        LocalizationKeys.menuStats
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

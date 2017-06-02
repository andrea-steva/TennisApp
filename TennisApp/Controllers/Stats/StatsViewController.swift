//
//  StatsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Tamamushi

class StatsViewController: BaseViewController {

    // MARK: IBOutlets

    // MARK: ViewModel
    
    var viewModel: StatsViewModel!
    
    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_stats
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: self.navigationController!.navigationBar,
                                                                  direction: .vertical, startColor: Style.Colors.courtGrass,
                                                                  endColor: Style.Colors.courtGrass.lighter())
    }
}
